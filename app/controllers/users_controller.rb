class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
    @book = Book.new
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
    
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
        render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="User info was successfully updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def followed
      @user  = User.find(params[:id])
      @users = @user.followed
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.follower
    render 'show_follower'
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
