class AddBookingStatusColumnToPropertyOwnerTable < ActiveRecord::Migration
  def change
  	add_column :property_posts,	:booking_status, :string
  end
end
