class CreateNotifactions < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.integer :user_id
    	t.integer :notification_type
    	t.string :title
    	t.string :message
      t.integer :related_id
    	t.boolean :read, :default => false

      t.timestamps
    end
  end
end
