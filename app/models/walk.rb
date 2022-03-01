class Walk < ApplicationRecord
  belongs_to :user
  belongs_to :original_walk, optional: true, class_name: "Walk"
  has_many :hotspot_walks
  has_many :hotspots, through: :hotspot_walks
  has_many :waypoints
  has_many :reviews

  validates :name, presence: true, length: { minimum: 6 }
  # validates :description, presence: true, length: { in: 6..500 }
  validates :date, presence: true
  validates :duration, presence: true
  validates :length, presence: true
  validates :published, presence: true, default: false
end
