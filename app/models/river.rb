class River < ActiveRecord::Base
	acts_as_gmappable

	has_many :guide_posts
	geocoded_by :make_nice_address
	after_validation :geocode, :if => :address_changed?

	def gmaps4rails_address
	  "#{self.address}, #{self.city}, #{self.country}" 
	end

	def make_nice_address
		"#{self.address} #{self.city} #{self.state}, #{self.country}" 
	end

	def to_s
		make_nice_address
	end
end
