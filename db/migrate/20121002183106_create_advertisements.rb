class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
    	t.string :headline
    	t.text :description
    	t.string :keywords
    	t.string :email
    	t.string :company_name
    	t.string :contact_name

    	t.string :photo_file_name
    	t.string :photo_content_type
    	t.integer :photo_file_size
    	t.datetime :photo_updated_at

      t.timestamps
    end
  end
end
