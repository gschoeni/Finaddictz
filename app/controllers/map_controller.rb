class MapController < ApplicationController
	def index
		@booked_pins = GuidePost.find_all_by_booking_status_id(BookingStatus.find_by_status("Booked"))
		@pending_pins = GuidePost.find_all_by_booking_status_id(BookingStatus.find_by_status("Pending"))
	end
end
