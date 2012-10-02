class AddPagesTable < ActiveRecord::Migration
  def change
  	create_table :pages do |t|
  		t.string :name
  		t.timestamps
  	end

  	create_table :advertisements_pages do |t|
  		t.integer :advertisement_id
  		t.integer :page_id
  		t.timestamps
  	end
  end

end
