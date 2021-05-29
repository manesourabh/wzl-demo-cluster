class CreateSensorValues < ActiveRecord::Migration[5.2]
  def change
    create_table :sensor_values do |t|
      t.string :sensor_name
      t.integer :sensor_value

      t.timestamps
    end
  end
end
