class MapController < ApplicationController
	def index
		@month = Time.now.month
		@day = Time.now.day
		@year = Time.now.year
		if params == {"controller"=>"map", "action"=>"index"} 
			params.merge!({:month => @month, :day => @day, :type => "both"})
		end
		if params[:month].to_i < 10
			params[:month] = "0#{params[:month]}"
		end
		search_date = "#{@year}-#{params[:month]}-#{params[:day]}"
		puts search_date
		if params[:type] == "both"
			@booked_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), Time.parse(search_date))
			@pending_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Pending"), Time.parse(search_date))
			AnglerPost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), search_date).each do |post|
				@booked_pins.push(post)
			end
		elsif params[:type] == "angler"
			@booked_pins = AnglerPost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), search_date)
			@pending_pins = []
		else #type is guide
			@booked_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), Time.parse(search_date))
			@pending_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Pending"), Time.parse(search_date))
		end
		
	end
end
