class AddNewMessageToConversation < ActiveRecord::Migration
  def change
  	add_column :conversations, :new_message, :boolean, :default => true
  end
end
