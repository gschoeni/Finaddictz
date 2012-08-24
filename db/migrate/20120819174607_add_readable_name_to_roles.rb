class AddReadableNameToRoles < ActiveRecord::Migration
  def change
  	add_column :roles, :readable_name, :string
  end
end
