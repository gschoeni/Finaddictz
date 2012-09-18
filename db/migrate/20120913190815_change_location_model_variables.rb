class ChangeLocationModelVariables < ActiveRecord::Migration
  def up
  	drop_table :locations
  	create_table :locations do |t|
      t.float :latitude
    	t.float :longitude
    	t.string :address
    	t.integer :radius
      t.boolean :gmaps

      t.timestamps
    end
  end

  def down
  	drop_table :locations
  	create_table :locations do |t|
      t.decimal :center_lat
      t.decimal :center_long
      t.decimal :radius
      t.string :name

      t.timestamps
    end
  end
end
