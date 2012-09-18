class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.boolean :read, :default => false
      t.integer :user_id
      t.integer :conversation_id

      t.timestamps
    end
  end
end
