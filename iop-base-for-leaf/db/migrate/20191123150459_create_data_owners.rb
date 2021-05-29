class CreateDataOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :data_owners do |t|
      t.references :group, foreign_key: true
      t.text :dataset_name

      t.timestamps
    end
  end
end
