class FishSpecy < ActiveRecord::Base
  validates :name, :presence => true
end
