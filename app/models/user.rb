class User < ApplicationRecord
    has_many :posts

    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255}
    has_secure_password
end
