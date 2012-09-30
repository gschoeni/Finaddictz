class AddAbusiveFlagCols < ActiveRecord::Migration
  def up
  	add_column :property_posts,	:abusive_flag, :boolean, :default => false
  	add_column :angler_posts,	:abusive_flag, :boolean, :default => false
  end

  def down
  end
end
