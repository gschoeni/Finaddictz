class AddLocationToPosts < ActiveRecord::Migration
  def change
  	add_column :guide_posts, :location_id, :integer
  	add_column :angler_posts, :location_id, :integer
  	add_column :property_posts, :location_id, :integer

  	add_column :guide_posts, :river_id, :integer
  	add_column :angler_posts, :river_id, :integer
  	add_column :property_posts, :river_id, :integer
  end
end
