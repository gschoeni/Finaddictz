class Page < ActiveRecord::Base

	has_and_belongs_to_many :advertisements

	def to_s
		name
	end
end
