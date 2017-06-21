class ConfirmsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_request!

  def index
    if @request.poster_id == @current_user_id
      @helpers = User.where(id: @request.user_followers.pluck(:id))

      @helpers_count = @helpers.count

      @helpers = @helpers.order(yellowStars: :desc).offset(params[:offset] || 0).limit(params[:limit] || 10)
    else
      render json: { errors: { requests: ['not owned by user'] } }, status: :forbidden
    end
  end

  def update
    if @request.poster_id == @current_user_id
      @helpers = User.where(id: @request.user_followers.pluck(:id))
      @helper = User.find_by_username!(params[:username])
      if @helpers.include?(@helper)
        @request.tag_list.remove("ongoing").add("ongoing-taken")
        @request.update_attributes(:helper => @helper)

        render 'requests/show'
      else
        render json: { errors: { helper: ['not valid']}}
      end
    else
      render json: { errors: { request: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def find_request!
    @request = Request.find_by_request_id!(params[:request_request_id])
  end
end
