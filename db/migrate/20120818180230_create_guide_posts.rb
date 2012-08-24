class CreateGuidePosts < ActiveRecord::Migration
  def change
    create_table :guide_posts do |t|
      t.integer :user_id
      t.text :description
      t.integer :num_people
      t.integer :price_per
      t.date :date
      t.string :time
      t.string :status

      t.timestamps
    end
  end
end
