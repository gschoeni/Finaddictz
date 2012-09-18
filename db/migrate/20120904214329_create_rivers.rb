class CreateRivers < ActiveRecord::Migration
  def change
    create_table :rivers do |t|
    	t.float :latitude
    	t.float :longitude
    	t.string :address
      t.string :city
      t.string :state
      t.string :country
    	t.string :keyword
    	t.integer :radius
      t.boolean :gmaps
      t.timestamps
    end
  end
end
