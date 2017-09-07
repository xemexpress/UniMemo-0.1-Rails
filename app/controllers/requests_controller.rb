class RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :fix_expired_and_old, except: [:create]
  before_action :find_request!, only: [:show, :update, :destroy]

  def index
    @requests = Request.includes(:poster, :helper)

    @requests = @requests.where.not(poster: current_user.following_users)

    @requests = @requests.where.not(id: @requests.tagged_with(params[:not_this_tag]).pluck(:id)) if params[:not_this_tag].present?

    @requests = @requests.tagged_with(params[:tag]) if params[:tag].present?

    @requests = @requests.posted_by(params[:poster]) if params[:poster].present?

    @requests = @requests.helped_by(params[:helper]) if params[:helper].present?

    @requests = @requests.wished_by(params[:wisher]) if params[:wisher].present?

    @requests_count = @requests.count

    @requests = @requests.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 10)
  end

  def taking
    @requests = current_user.following_requests

    @requests = @requests.tagged_with(params[:tag]) if params[:tag].present?

    @requests_count = @requests.count

    @requests = @requests.order(:created_at).offset(params[:offset] || 0).limit(params[:limit] || 10)

    render :index
  end

  def collect
    @requests_wished_by_favored_users = Request.where(id: Request.joins(:wishes).where(wishes: { user: current_user.following_users } ).pluck(:id))

    @requests = Request.where(poster: current_user.following_users).or(@requests_wished_by_favored_users)

    @requests = @requests.tagged_with(params[:tag]) if params[:tag].present?

    @requests_count = @requests.count

    @requests = @requests.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 10)

    render :index
  end

  def furtherCollect
    # A Series
    @favored_users = current_user.following_users

    # Init B Series [array]
    @further_favored_users = []

    # Get B Series
    @favored_users.each do |user|
      @further_favored_users = @further_favored_users + user.following_users
    end

    @further_favored_users = @further_favored_users - @favored_users - [current_user]

    @further_favored_users.uniq

    @requests = Request.where(poster: @further_favored_users)

    @requests = @requests.tagged_with(params[:tag]) if params[:tag].present?

    @requests_count = @requests.count

    @requests = @requests.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 10)

    render :index
  end


  def create
    @request = Request.new(request_params)
    @request.poster = @request.helper = current_user

    if @request.save
      @request.request_id = rand(36**3).to_s(36) + Hashids.new("UniMemo").encode(@request.id) + rand(36**3).to_s(36)
      @request.save!

      render :show
    else
      render json: { errors: @request.errors }, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @request.poster_id == @current_user_id
      @request.update_attributes(request_params)

      render :show
    else
      render json: { errors: { request: ['not posted by user'] } }, status: :forbidden
    end
  end

  def destroy
    if @request.poster_id == @current_user_id
      @request.destroy

      render json: {}
    else
      render json: { errors: { request: ['not posted by user'] } }, status: :forbidden
    end
  end

  private

  def request_params
    params.require(:request).permit(:start_time, :start_place, :end_time, :end_place, :text, :image, tag_list: [])
  end

  def find_request!
    @request = Request.find_by_request_id!(params[:request_id])
  end

  def fix_expired_and_old
    @requests = Request.all
    @requests.old.destroy_all
    @requests.expired.find_each do |request|
      request.tag_list.remove('ongoing').add('done') if request.tag_list.include?('ongoing')
      request.save!
    end
  end
end
