class Waypoint < ApplicationRecord
  belongs_to :walk

  validates :longitude, presence: true
  validates :latitude, presence: true
end
