class CreatePropertyPosts < ActiveRecord::Migration
  def change
    create_table :property_posts do |t|

      t.timestamps
    end
  end
end
