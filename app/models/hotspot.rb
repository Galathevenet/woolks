class Hotspot < ApplicationRecord
  has_many :hotspot_walks
  has_many :walks, through: :hotspot_walks

  validates :category, inclusion: { in: ["dog park", "dispenser", "fountain"] }
  validates :longitude, presence: true
  validates :latitude, presence: true
end
