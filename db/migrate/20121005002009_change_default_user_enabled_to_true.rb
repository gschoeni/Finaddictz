class ChangeDefaultUserEnabledToTrue < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change :enable, :boolean, :default => true
    end
  end

  def self.down
    change_table :users do |t|
      t.change :enable, :boolean, :default => false
    end
  end
end
