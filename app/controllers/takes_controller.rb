class TakesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_request!

  def create
    current_user.follow(@request) if @current_user_id != @request.poster_id

    render 'requests/show'
  end

  def destroy
    current_user.stop_following(@request) if @current_user_id != @request.poster_id

    render 'requests/show'
  end

  private

  def find_request!
    @request = Request.find_by_request_id!(params[:request_request_id])
  end
end
