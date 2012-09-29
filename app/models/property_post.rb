class PropertyPost < ActiveRecord::Base

#validations
validates :price, :numericality => { :greater_than_or_equal_to => 1 }
#end validations

#relations
	belongs_to :user
#end relations
end
