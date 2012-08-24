class FishingMethod < ActiveRecord::Base
  validates :name, :presence => true
end
