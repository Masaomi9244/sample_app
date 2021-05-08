class Post < ApplicationRecord
    validates :content, {presence: true, length: {maximum: 140}}
    validates :user_id, {presence: true}

    def user
        return User.find_by(id: self.user_id)
    end

    has_many :likes
end
