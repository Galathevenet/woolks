class Walk < ApplicationRecord
  belongs_to :user
  belongs_to :original_walk, optional: true, class_name: "Walk"
  has_many :hotspot_walks
  has_many :hotspots, through: :hotspot_walks
  has_many :waypoints, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many_attached :photos

  validates :name, presence: true, length: { minimum: 6 }
  # validates :description, presence: true, length: { in: 6..500 }
  validates :date, presence: true
  validates :duration, presence: true
  validates :length, presence: true
  validates :published, exclusion: [nil]

  def reviews_average
    walk = Walk.find(id)
    rating_sum = 0
    walk.reviews.each do |review|
      rating_sum += review.rating
    end
    if reviews.size >= 1
      rating_sum / walk.reviews.size
    else
      0
    end
  end
end
