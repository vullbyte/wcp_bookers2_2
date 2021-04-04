class BooksController < ApplicationController

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book.user == current_user
    @favorite = Favorite.new
    @comment = BookComment.new
    @comments = BookComment.all
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
    @favorite = Favorite.new
    #@comments = @book.book_comments  #投稿詳細に関連付けてあるコメントを全取得
    #@comment = current_user.book_comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have creatad book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :book_id)
  end

end
