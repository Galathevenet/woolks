class Review < ApplicationRecord
  belongs_to :walk
  belongs_to :user

  validates :comment, presence: true, length: { minimum: 8 }
  validates :rating, presence: true
  validates :favorite, presence: true, default: false
end
