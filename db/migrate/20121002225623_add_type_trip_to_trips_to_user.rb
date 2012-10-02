class AddTypeTripToTripsToUser < ActiveRecord::Migration
  def change
  	add_column :trips_to_users, :type_of_trip, :string, :default => "guide"
  end
end
