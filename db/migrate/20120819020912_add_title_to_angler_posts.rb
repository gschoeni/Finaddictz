class AddTitleToAnglerPosts < ActiveRecord::Migration
  def change
    add_column :angler_posts, :title, :string
  end
end
