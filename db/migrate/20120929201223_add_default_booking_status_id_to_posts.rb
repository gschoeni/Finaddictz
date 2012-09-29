class AddDefaultBookingStatusIdToPosts < ActiveRecord::Migration
  def change
  	change_column_default(:guide_posts, :booking_status_id, 3)
  	change_column_default(:angler_posts, :booking_status_id, 3)
  	change_column_default(:property_posts, :booking_status_id, 3)
  end
end
