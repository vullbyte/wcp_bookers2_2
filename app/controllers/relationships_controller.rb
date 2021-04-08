class RelationshipsController < ApplicationController
  before_action :user_params

  def create
    current_user.follow(@user)
    redirect_back fallback_location: users_path
  end

  def destroy
    current_user.unfollow(@user)
    redirect_back fallback_location: users_path
  end

  private
  def user_params
    @user = User.find(params[:relationship][:followed_id])
  end

end
