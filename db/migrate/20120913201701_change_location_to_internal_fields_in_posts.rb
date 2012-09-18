class ChangeLocationToInternalFieldsInPosts < ActiveRecord::Migration
  def change
  	remove_column :guide_posts, :location_id
  	remove_column :angler_posts, :location_id
  	remove_column :property_posts, :location_id

		add_column :guide_posts, :latitude, :float
		add_column :guide_posts, :longitude, :float

		add_column :angler_posts, :latitude, :float
		add_column :angler_posts, :longitude, :float

		add_column :property_posts, :latitude, :float
		add_column :property_posts, :longitude, :float
  end

end
