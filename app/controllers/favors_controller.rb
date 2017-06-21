class FavorsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user!

  def create
    current_user.follow(@user) if @current_user_id != @user.id

    render 'profiles/show'
  end

  def destroy
    current_user.stop_following(@user) if @current_user_id != @user.id

    render 'profiles/show'
  end

  private

  def find_user!
    @user = User.find_by_username!(params[:profile_username])
  end
end
