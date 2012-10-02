class Advertisement < ActiveRecord::Base
	has_attached_file :photo, :styles => { :full => "460x60!"}, :default_url => '/images/OGBbanner.jpg'
	has_and_belongs_to_many :pages


end
