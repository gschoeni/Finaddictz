class AddAbusedFlagToGuidePosts < ActiveRecord::Migration
  def change
  	add_column :guide_posts, :abusive_flag, :boolean, :default => false
  end
end
