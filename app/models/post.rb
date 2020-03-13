class Post < ApplicationRecord
    validates :title, presence: true, length: {maximum: 50}
    validates :body, length: {maximum: 255}
end
