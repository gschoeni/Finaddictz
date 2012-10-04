class AddAcceptedFieldToTripsToUser < ActiveRecord::Migration
  def change
  	add_column :trips_to_users, :accepted, :boolean, :default => false
  end
end
