class GuidePost < ActiveRecord::Base
	#these are methods that are shared between AnglerPost and GuidePost
	include SharedPostMethods
  [:title, :description, :date, :price_per].each do |v|
    validates v, :presence => true
  end
  validates :price_per, :numericality => { :greater_than_or_equal_to => 0 }
	belongs_to :user

	belongs_to :river
	belongs_to :booking_status

	
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
	      params[:price_max] = 1000 unless (params[:price_max] == nil)
	      params[:price_min] = 0 unless (params[:price_min] == nil)
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
