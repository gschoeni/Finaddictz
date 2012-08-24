class EnvPref < ActiveRecord::Base
  validates :name, :presence => true
end
