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
  has_many :book_comments, dependent: :destroy

  has_many :followed_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent:   :destroy
  has_many :followed, through: :followed_relationships,  source: :followed

  has_many :follower_relationships,  class_name: "Relationship", foreign_key: "followed_id", dependent:   :destroy
  has_many :follower, through: :follower_relationships, source: :follower

  attachment :profile_image

  def favorited_by?(book)
    favorites.where(book_id: book.id).exists?
  end

  def follow(other_user)
    unless self == other_user
      self.followed_relationships.create!(followed_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.followed_relationships.find_by(followed_id: other_user.id)
    relationship.destroy if relationship
  end

  def followed?(other_user)
    followed.include?(other_user)
  end

  def self.search(search,word)
    if search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @user = User.where(name: word)
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
