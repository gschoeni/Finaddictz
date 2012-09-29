class MapController < ApplicationController
	def index
		@month = Time.now.month
		@day = Time.now.day
		if params == {"controller"=>"map", "action"=>"index"} 
			params.merge!({:month => @month, :day => @day})
		end
		@booked_pins = GuidePost.find_all_by_booking_status_id(BookingStatus.find_by_status("Booked"))
		@pending_pins = GuidePost.find_all_by_booking_status_id(BookingStatus.find_by_status("Pending"))
	end
end
