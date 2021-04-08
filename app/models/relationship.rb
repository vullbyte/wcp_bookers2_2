class Relationship < ApplicationRecord
belongs_to :follower, class_name: "User" #フォローするユーザのid
belongs_to :followed, class_name: "User" #フォローされるユーザのid

validates :follower_id, presence: true
validates :followed_id, presence: true


end
