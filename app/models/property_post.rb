class PropertyPost < ActiveRecord::Base

	#validations
	validates :price, :numericality => { :greater_than_or_equal_to => 1 }
	#end validations

	#relations
		belongs_to :user
		belongs_to :booking_status
	#end relations

	searchable do
	  text :title, :boost => 5 
	  text :description
    time :created_at
	end

	#called from the controller passed in params
  def self.fullSearch(params)
  	paginate :page => params[:page] || 1, :per_page => 10
  	begin
	  	search = PropertyPost.search do
	  		#the full text search
	      fulltext params[:search]
	      paginate :page => params[:page] || 1, :per_page => 10
	      order_by :created_at, :desc
	    end
	    search.results
	  rescue
	  	search = PropertyPost.search do
	  		paginate :page => params[:page] || 1, :per_page => 10
	  		order_by :created_at, :desc
	  	end
	  	search.results
	  end
  end

end
