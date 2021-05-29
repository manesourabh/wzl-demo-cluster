class AddUniquenessToContractIdInContracts < ActiveRecord::Migration[5.2]
  def change
    change_column :contracts, :contract_id, :string, unique: true
  end
end
