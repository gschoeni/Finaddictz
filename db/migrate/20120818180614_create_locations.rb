class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :center_lat
      t.decimal :center_long
      t.decimal :radius
      t.string :name

      t.timestamps
    end
  end
end
