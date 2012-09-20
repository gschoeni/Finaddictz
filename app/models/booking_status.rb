class BookingStatus < ActiveRecord::Base
	has_many :guide_posts
	has_many :property_posts
	has_many :angler_posts

	def to_s
		status
	end
end
