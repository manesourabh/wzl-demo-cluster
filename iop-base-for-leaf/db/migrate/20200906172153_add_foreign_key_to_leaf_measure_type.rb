class AddForeignKeyToLeafMeasureType < ActiveRecord::Migration[5.2]
  def change
    add_reference :leaf_measure_types, :leaf_failure_type, foreign_key: true
  end
end
