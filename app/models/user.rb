class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2, maximum: 20}
  validates :introduction, length: { maximum: 50 }
  validates :name, uniqueness: true

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #has_many :favorited_books, through: :favorites, source: :book
  attachment :profile_image

  def favorited_by?(book_id)
    favorites.where(book_id: book_id).exists?
  end

  #def already_favorited?(book)
  #  self.favorites.exists?(book_id: book.id)
  #   likes.exists?(post_id: post.id)
  #end

end
