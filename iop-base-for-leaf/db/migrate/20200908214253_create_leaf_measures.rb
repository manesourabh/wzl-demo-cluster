class CreateLeafMeasures < ActiveRecord::Migration[5.2]
  def change
    create_table :leaf_measures do |t|
      t.references :leaf_measure_type, foreign_key: true
      t.references :leaf_failure, foreign_key: true

      t.timestamps
    end
  end
end
