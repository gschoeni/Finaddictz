class AddTitleToGuidePosts < ActiveRecord::Migration
  def change
    add_column :guide_posts, :title, :string
  end
end
