class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = BookComment.new(comment_params)
    comment.save
    redirect_to request.referer
  end
  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    redirect_to request.referer
  end

  def comment_params
    params.require(:book_comment).permit(:comment).merge(user_id: current_user.id, book_id: params[:book_id])
  end

end
