class MapController < ApplicationController
	def index
		@pins = GuidePost.find_all_by_booking_status_id(BookingStatus.find_by_status("Booked"))
	end
end
