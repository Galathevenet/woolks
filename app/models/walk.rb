class Walk < ApplicationRecord

  belongs_to :user

  belongs_to :original_walk, optional: true, class_name: "Walk"
  has_many :walks, foreign_key: :original_walk_id, dependent: :nullify
  has_many :hotspot_walks, dependent: :destroy
  has_many :hotspots, through: :hotspot_walks
  has_many :waypoints, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many_attached :photos

  validates :name, presence: true, length: { minimum: 6, maximum: 30 }
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

  scope :less_than_fifteen, -> { where("duration <= 900") }
  scope :less_than_thirty, -> { where("duration <= 1800 AND duration > 900") }
  scope :one_hour, -> { where("duration <= 3600 AND duration > 1800") }
  scope :one_hour_thirty, -> { where("duration <= 5400 AND duration > 3600") }
  scope :two_hours, -> { where("duration <= 7200 AND duration > 5400") }
  scope :more_than_two, -> { where("duration > 7200") }


  scope :park_walks, -> { joins(:hotspots).where("hotspots.category = 'dog park'") }
  scope :fountain_walks, -> { joins(:hotspots).where("hotspots.category = 'fountain'") }
  scope :dispenser_walks, -> { joins(:hotspots).where("hotspots.category = 'dispenser'") }

  scope :joins_hotspots, -> { joins(:hotspots) }
end
