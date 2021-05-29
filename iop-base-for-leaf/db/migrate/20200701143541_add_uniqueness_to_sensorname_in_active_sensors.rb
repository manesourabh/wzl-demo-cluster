class AddUniquenessToSensornameInActiveSensors < ActiveRecord::Migration[5.2]
  def change
    change_column :active_sensors, :sensor_name, :string, unique: true
  end
end
