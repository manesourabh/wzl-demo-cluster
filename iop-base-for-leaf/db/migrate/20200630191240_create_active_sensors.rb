class CreateActiveSensors < ActiveRecord::Migration[5.2]
  def change
    create_table :active_sensors do |t|
      t.string :sensor_name
      t.string :contract_id

      t.timestamps
    end
  end
end
