class CreateEnvPrefs < ActiveRecord::Migration
  def change
    create_table :env_prefs do |t|
      t.string :name

      t.timestamps
    end
  end
end
