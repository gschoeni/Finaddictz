class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :title
      t.integer :user_id1
      t.integer :user_id2

      t.timestamps
    end
  end
end
