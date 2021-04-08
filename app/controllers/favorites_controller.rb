class FavoritesController < ApplicationController
   before_action :book_params

  def create
    @favorite = current_user.favorites.create(book_id: params[:book_id])
    redirect_to request.referer
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    @favorite.destroy
    redirect_to request.referer
  end

  private
  def favorite_params
    params.require(:favorite).permit(:user_id, :book_id)
  end

  def book_params
    @book = Book.find(params[:book_id])
  end

end
