class Conversation < ActiveRecord::Base
	has_many :messages
	accepts_nested_attributes_for :messages

	def has_new_message?(user)
		self.new_message and user != self.messages.last.user
	end
	
	#static functions
	def self.get_users_conversations(current_user)
		conversations = Conversation.find_all_by_user_id1(current_user.id, :order => "updated_at desc")
    next_convos = Conversation.find_all_by_user_id2(current_user.id, :order => "updated_at desc")
    next_convos.each {|c| conversations.push(c) }
    
    #sort by time
    conversations.sort_by! { |hsh| hsh.updated_at.to_i }
    #sorts smallest time first so we have to reverse it for display
    conversations.reverse!
	end

	def self.get_num_unread_conversations(current_user)
		convos = Conversation.find_all_by_user_id1_and_new_message(current_user.id, true)
    next_convos = Conversation.find_all_by_user_id2_and_new_message(current_user.id, true)

    total = 0
    next_convos.each{|c|
    	if c.messages.last.user != current_user
    		total = total + 1
    	end
    }

    convos.each{|c|
    	if c.messages.last.user != current_user
    		total = total + 1
    	end
    }


    total
	end

end
