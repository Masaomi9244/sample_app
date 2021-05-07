class Like < ApplicationRecord
  validates :user_id, {presence: true}
  validates :post_id, {presence: true}

  has_many :user
  has_many :post
end
