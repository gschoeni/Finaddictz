class AddStatusIdToPosts < ActiveRecord::Migration
  def change
  	add_column :guide_posts, :booking_status_id, :integer
  	add_column :angler_posts, :booking_status_id, :integer
  	add_column :property_posts, :booking_status_id, :integer
  end
end
