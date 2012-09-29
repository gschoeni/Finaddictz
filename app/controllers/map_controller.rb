class MapController < ApplicationController
	def index
		@month = Time.now.month
		@day = Time.now.day
		@year = Time.now.year
		if params == {"controller"=>"map", "action"=>"index"} 
			params.merge!({:month => @month, :day => @day})
		end
		d = Time.parse("#{@year}-#{params[:month]}-#{params[:day]}")
		@booked_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), d)
		@pending_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Pending"), d)
	end
end
