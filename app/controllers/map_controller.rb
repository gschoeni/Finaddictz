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
		if params[:day].to_i < 10
			params[:day] = "0#{params[:day]}"
		end
		search_date = "#{@year}-#{params[:month]}-#{params[:day]}"
		puts search_date
		if params[:type] == "both"
			@booked_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), search_date)
			@pending_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Pending"), search_date)
			AnglerPost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), search_date).each do |post|
				@booked_pins.push(post)
			end
		elsif params[:type] == "angler"
			@booked_pins = AnglerPost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), search_date)
			@pending_pins = []
		else #type is guide
			@booked_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Booked"), search_date)
			@pending_pins = GuidePost.find_all_by_booking_status_id_and_date(BookingStatus.find_by_status("Pending"), search_date)
		end
		@num_trips = @booked_pins.count + @pending_pins.count
		
	end
end
