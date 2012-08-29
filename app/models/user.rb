class User < ActiveRecord::Base
	acts_as_authentic
  has_and_belongs_to_many :roles
  has_one :guide_ext
  has_one :prop_ext
  has_one :angler_ext

  before_save :make_angler

  accepts_nested_attributes_for :guide_ext, :prop_ext, :angler_ext

  has_attached_file :photo, :styles => { :small => "50x50>", :medium => "150x150>", :full => "500x500>"}, :default_url => '/images/no_prof.png'

  [:first_name, :last_name, :active_role].each do |v|
    validates v, :presence => true
  end


  searchable do
    text :email, :first_name, :last_name
    date :created_at
  end


  #called from the controller passed in params
  def self.fullSearch(params)
    begin
      search = User.search do
        #the full text search
        fulltext params[:term]
        
        paginate :page => params[:page] || 1, :per_page => 10
        order_by :created_at, :desc
      end
      search.results
    #we'll just give a vanilla search if they really f something up and break the code above
    rescue
      # search = User.search do
      #   paginate :page => params[:page] || 1, :per_page => 10
      #   order_by :created_at, :desc
      # end
      # search.results
    end
  end


	def role_symbols
		if active_role
      [active_role.downcase.to_sym]
    else
      [:guest]
    end
  end


  def my_posts
    if active_role == "angler"
      AnglerPost.find_all_by_user_id(self.id, :order => "created_at DESC")
    elsif active_role == "guide"
      GuidePost.find_all_by_user_id(self.id, :order => "created_at DESC")
    end
  end

  #make sure everyone is always an angler (even if the uncheck the box)
  def make_angler
    unless self.roles.include?(Role.find_by_name("angler"))
      self.roles << Role.find_by_name("angler")
    end
  end

	def to_s
    "#{first_name} #{last_name}"
  end

  def disabled?
    !self.enable
  end


  def about
    if active_role == "angler"
      self.angler_ext.about
    elsif active_role == "guide"
      self.guide_ext.about
    else
      self.prop_ext.about
    end
  end
end
