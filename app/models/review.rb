class Review < ApplicationRecord
  belongs_to :walk
  belongs_to :user

  has_many_attached :photos

  validates :comment, presence: true, length: { minimum: 8 }
  validates :rating, presence: true
end
