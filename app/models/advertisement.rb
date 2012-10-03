class Advertisement < ActiveRecord::Base
	has_attached_file :photo, :styles => { :full => "460x60!"}, :default_url => '/images/OGBbanner.jpg'
	has_and_belongs_to_many :pages

	[:headline, :description, :url, :email, :company_name, :contact_name].each do |v|
    validates v, :presence => true
  end

  validates :email, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validate :valid_url

  def valid_url
	  begin
    	uri = URI.parse(url)
	    if uri.class != URI::HTTP
	      errors.add(:url, 'Make sure you enter a valid URL')
	    end
    rescue URI::InvalidURIError
      errors.add(:url, 'The format of the url is not valid.')
    end
  end
end
