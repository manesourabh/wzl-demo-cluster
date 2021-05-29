class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string :contract_id
      t.string :name
      t.integer :fvalue
      t.boolean :alarm
      t.string :email

      t.timestamps
    end
    add_index :contracts, :contract_id
  end
end
