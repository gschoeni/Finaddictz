class Message < ActiveRecord::Base
	belongs_to :conversation
	belongs_to :user
	accepts_nested_attributes_for :conversation

	def who(current_user)
		if self.user == current_user
			"You"
		else 
			self.user
		end
	end

	def getUserId(current_user)
		if self.conversation.user_id1 != current_user.id
			self.conversation.user_id1
		else 
			self.conversation.user_id2
		end
	end

	def to_s
		self.text
	end
end
