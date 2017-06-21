class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_request!

  def index
    @comments = @request.comments.order(:created_at)
  end

  def create
    @comment = @request.comments.new(comment_params)
    @comment.user = current_user

    render json: { errors: @comment.errors }, status: :unprocessable_entity unless @comment.save
  end

  def update
    @comment = @request.comments.find(params[:id])
    if @comment.user_id == @current_user_id
      @comment.update_attributes(comment_params)

      render :create
    else
      render json: { errors: { comments: ['not owned by user'] } }, status: :forbidden
    end
  end

  def destroy
    @comment = @request.comments.find(params[:id])

    if @comment.user_id = @current_user_id
      @comment.destroy
      render json: {}
    else
      render json: { errors: { comments: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_request!
    @request = Request.find_by_request_id!(params[:request_request_id])
  end
end
