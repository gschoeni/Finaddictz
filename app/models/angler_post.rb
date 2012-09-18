class AnglerPost < ActiveRecord::Base
  include SharedPostMethods

  [:title, :description, :date].each do |v|
    validates v, :presence => true
  end

  validates :price_min, :if => :price_min, :numericality => { :greater_than_or_equal_to => 0 }
  validates :price_max, :if => :price_max, :numericality => { :greater_than_or_equal_to => 0 }
  validates :price_min, :if => :price_min, :numericality => { :greater_than_or_equal_to => 0 }
  validates :price_max, :if => :price_max, :numericality => { :greater_than_or_equal_to => 0 }

  belongs_to :user
  belongs_to :river

  #make angler posts more dynamically searchable sunspot
  searchable do
    text :title, :boost => 5 
    text :description
    integer :price_min
    integer :price_max
    time :date
  end

  #called from the controller passed in params
  def self.fullSearch(params)
    begin
      search = AnglerPost.search do
        #the full text search
        fulltext params[:search]


        #the pricing search params
        params[:price_max] = 1000 unless (params[:price_max] == nil)
        params[:price_min] = 0 unless (params[:price_min] == nil)
        #puts "price max: #{(params[:price_max] == nil)}"
        with(:price_min, params[:price_min].to_i..params[:price_max].to_i)
        with(:price_max, params[:price_min].to_i..params[:price_max].to_i)

        #expects 08/19/2012 for dates
        if params[:start_date].present?
          t = string_to_time(params[:start_date])

          with(:date).greater_than t
        end 


        if params[:end_date].present?
          
          t = string_to_time(params[:end_date])
          puts "woo #{t}"
          with(:date).less_than t
        end 

        
        #with(:date).greater_than params[:start_date] if params[:start_date].present?
        paginate :page => params[:page] || 1, :per_page => 10
        order_by :date, :desc
      end
      search.results
    #we'll just give a vanilla search if they really f something up and break the code above
    rescue
      search = AnglerPost.search do
        paginate :page => params[:page] || 1, :per_page => 10
        order_by :date, :desc
      end
      search.results
    end
  end

end


