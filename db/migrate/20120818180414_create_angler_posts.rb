class CreateAnglerPosts < ActiveRecord::Migration
  def change
    create_table :angler_posts do |t|
      t.integer :num_people
      t.integer :price_min
      t.integer :price_max
      t.date :date
      t.string :time
      t.text :description
      t.boolean :search_guide
      t.boolean :search_angler

      t.timestamps
    end
  end
end
