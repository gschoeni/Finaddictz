class AddColumnsToPropertyOwnerTable < ActiveRecord::Migration
  def change
    add_column :property_posts, :user_id, 	 	:integer
    add_column :property_posts,	:description, 	:text
    add_column :property_posts,	:title, 		:string
  end
end
