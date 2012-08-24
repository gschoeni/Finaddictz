class CreatePropExts < ActiveRecord::Migration
  def change
    create_table :prop_exts do |t|
      t.text :about
      t.integer :user_id

      t.timestamps
    end
  end
end
