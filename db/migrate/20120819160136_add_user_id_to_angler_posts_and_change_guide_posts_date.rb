class AddUserIdToAnglerPostsAndChangeGuidePostsDate < ActiveRecord::Migration
  def change
  	add_column :angler_posts, :user_id, :integer
  	#looks like date is fine of guide posts
  end
end
