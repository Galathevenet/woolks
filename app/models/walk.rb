class Walk < ApplicationRecord
  belongs_to :user
  belongs_to :original_walk, optional: true, class_name: "Walk"
end
