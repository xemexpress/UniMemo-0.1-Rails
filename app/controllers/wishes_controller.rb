class WishesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_request!

  def create
    current_user.wish(@request)

    render 'requests/show'
  end

  def destroy
    current_user.unwish(@request)

    render 'requests/show'
  end

  private

  def find_request!
    @request = Request.find_by_request_id!(params[:request_request_id])
  end
end
