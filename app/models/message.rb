class Message < ActiveRecord::Base
	belongs_to :conversation
	belongs_to :user
	accepts_nested_attributes_for :conversation
end
