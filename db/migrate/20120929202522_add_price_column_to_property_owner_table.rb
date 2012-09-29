class AddPriceColumnToPropertyOwnerTable < ActiveRecord::Migration
  def change
  	add_column :property_posts,	:price, :float
  end
end
