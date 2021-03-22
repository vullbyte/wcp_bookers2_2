class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true #空欄時にエラー
  validates :introduction, length: { maximum: 200 } #200文字以内に設定

  has_many :book, dependent: :destroy
  attachment :profile_image
end
