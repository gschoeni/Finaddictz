class AddingPreferencesToUser < ActiveRecord::Migration
  def up
    add_column :users, :notify_email, :boolean, :default => false
    add_column :users, :notify_sms,   :boolean, :default => false
    add_column :users, :notify_phone, :boolean, :default => false
    add_column :users, :notify_site,  :boolean, :default => false

  end

  def down
    remove_column :users, :notify_email
    remove_column :users, :notify_sms
    remove_column :users, :notify_phone
    remove_column :users, :notify_site
  end
end
