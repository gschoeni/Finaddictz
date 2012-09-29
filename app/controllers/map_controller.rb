class MapController < ApplicationController
	def index
		@month = Time.now.month
		@day = Time.now.day
		@year = Time.now.year
		if params == {"controller"=>"map", "action"=>"index"} 
			params.merge!({:month => @month, :day => @day, :type => "both"})
		end

		search_date = Time.parse("#{@year}-#{params[:month]}-#{params[:day]}")
		if params[:type] == "both"
			@booked_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), search_date)
			@pending_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Pending"), search_date)
		elsif params[:type] == "angler"
			@booked_pins = AnglerPost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), search_date)
			@pending_pins = []
		else
			@booked_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), search_date)
			@pending_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Pending"), search_date)
		end
		
	end
end
