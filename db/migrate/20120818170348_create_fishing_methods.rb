class CreateFishingMethods < ActiveRecord::Migration
  def change
    create_table :fishing_methods do |t|
      t.string :name

      t.timestamps
    end
  end
end
