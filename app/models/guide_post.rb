class GuidePost < ActiveRecord::Base
	#these are methods that are shared between AnglerPost and GuidePost
	include SharedPostMethods

	#validations
	class GuidePostValidator < ActiveModel::Validator
		#add custom validations to this method
	  def validate(record)
	  	interested_users = TripsToUser.find_all_by_post_id(record.id).count()
	    if interested_users > record.num_people && record.booking_status == BookingStatus.find_by_status("Booked")
	      record.errors[:num_people] << 'The number of users interested in your trip is greater than your initial estimate, you can fix this by removing users from the trip, or expanding the number of users for the trip.'
	    end
	    if interested_users == 0 && record.booking_status == BookingStatus.find_by_status("Booked")
	      record.errors[:num_people] << 'You must have people interested in your trip before you can mark it as booked.'
	    end
	  end
	end
	include ActiveModel::Validations


  [:title, :description, :date, :price_per].each do |v|
    validates v, :presence => true
  end
  validates :price_per, :numericality => { :greater_than_or_equal_to => 0 }
  validates_with GuidePostValidator
  #end validations

  #relations
	belongs_to :user
	belongs_to :river
	belongs_to :booking_status
	#end relations

	after_save :check_if_status_is_booked

	#has to go through booking validations first so we are good to just send out 
	#a notification to the user that requested the trip
	def check_if_status_is_booked
		if booking_status == BookingStatus.find_by_status("Booked")
			@trips = TripsToUser.find_all_by_post_id(self.id)
			@trips.each do |trip|
				Notification.create(
		      user_id: trip.user_who_agreed_id,
		      notification_type: NotificationType.find_by_name("trip_confirmed").id,
		      title: "Trip has been confirmed.",
		      message: "Your trip with #{self.user} is official, click the link below to view the trip details.",
		      related_id: self.id
		    )
			end
		end
	end
	
  #make guide posts more dynamically searchable sunspot
  searchable do
    text :title, :boost => 5 
    text :description
    integer :price_per
    time :date
  end

  #called from the controller passed in params
  def self.fullSearch(params)
  	begin
  		
	  	search = GuidePost.search do
	  		#the full text search
	      fulltext params[:search]

	      #the pricing search params
	      params[:price_max] = 1000 if (params[:price_max] == nil)
	      params[:price_min] = 0 if (params[:price_min] == nil)
	      with(:price_per, params[:price_min].to_i..params[:price_max].to_i)

	      #expects 08/19/2012 for dates
	      if params[:start_date].present?
	      	t = string_to_time(params[:start_date])
		      with(:date).greater_than t
		    end 


	      if params[:end_date].present?
	      	
		      t = string_to_time(params[:end_date])
		      #with(:date).between(Time.mktime(2012, 8, 5)..Time.mktime(2012, 8, 6))
		      with(:date).less_than t
		    end 

		    
	      #with(:date).greater_than params[:start_date] if params[:start_date].present?
	      paginate :page => params[:page] || 1, :per_page => 10
	      order_by :date, :desc
	    end
	    search.results
	  #we'll just give a vanilla search if they really f something up and break the code above
	  rescue
	  	search = GuidePost.search do
	  		paginate :page => params[:page] || 1, :per_page => 10
	  		order_by :date, :desc
	  	end
	  	search.results
	  end
  end

end


