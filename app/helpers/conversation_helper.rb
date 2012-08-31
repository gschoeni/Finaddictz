module ConversationHelper
	def from_who(conversation)
		if conversation.user_id1 != current_user.id
			User.find(conversation.user_id1)
		else
			User.find(conversation.user_id2)
		end
	end
end


