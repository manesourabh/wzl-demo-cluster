class CreateLeafMeasureTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :leaf_measure_types do |t|
      t.string :name
      t.integer :success_percent
      t.boolean :admin_approval

      t.timestamps
    end
  end
end
