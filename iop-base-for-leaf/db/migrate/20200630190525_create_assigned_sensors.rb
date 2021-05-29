class CreateAssignedSensors < ActiveRecord::Migration[5.2]
  def change
    create_table :assigned_sensors do |t|
      t.belongs_to :contract
      t.string :sensor_name
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
    add_index :assigned_sensors, :sensor_name
  end
end
