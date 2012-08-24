class CreateAnglerExts < ActiveRecord::Migration
  def change
    create_table :angler_exts do |t|
      t.date :fishing_license_exp
      t.text :about
      t.string :experience
      t.integer :user_id

      t.timestamps
    end
  end
end
