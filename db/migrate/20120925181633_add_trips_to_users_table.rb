class AddTripsToUsersTable < ActiveRecord::Migration
  def change
  	create_table :trips_to_users do |t|
    	t.integer :post_id
    	t.integer :post_booking_status_id
    	t.integer :user_who_posted_id
    	t.integer :user_who_agreed_id
    	t.boolean :trip_has_been_finished, :default => false
      t.timestamps
    end
  end
end
