class User < ApplicationRecord
    has_many :posts

    has_many :follows
   
    has_many :followers_relations, foreign_key: :following_id, class_name: 'Follow'
    has_many :followers, through: :followers_relations, source: :follower

    has_many :following_relations, foreign_key: :follower_id, class_name: 'Follow'
    has_many :following, through: :following_relations, source: :following


    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255}
    has_secure_password
end
