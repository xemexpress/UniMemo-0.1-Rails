class EndsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_request!

  def update
    if @request.poster_id == @current_user_id && @request.tag_list.include?("ongoing-taken")
      if @request.helper_id == @current_user_id
        @request.tag_list.remove("ongoing-taken").add("done")
        @request.save

        render 'requests/show'
      else
        @helper = User.find(@request.helper_id)

        if params[:mem].to_i > 0
          @helper.update_attributes(:mem => (@helper.mem || 0) + (params[:mem].to_i || 0), :yellowStars => (@helper.yellowStars || 0) + 1)
          @request.tag_list.remove("ongoing-taken").add("done")
          @request.save

          render 'requests/show'
        else
          render json: { errors: { mem: ['should be equal or greater than 0'] } }, status: :unprocessable_entity
        end
      end
    else
      render json: { errors: { request: ['can only be ended by poster once'] } }, status: :forbidden
    end
  end

  private

  def find_request!
    @request = Request.find_by_request_id!(params[:request_request_id])
  end
end
