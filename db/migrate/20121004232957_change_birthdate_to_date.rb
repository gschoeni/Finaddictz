class ChangeBirthdateToDate < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change :birthdate, :date
    end
  end

  def self.down
    change_table :users do |t|
      t.change :birthdate, :string
    end
  end
end
