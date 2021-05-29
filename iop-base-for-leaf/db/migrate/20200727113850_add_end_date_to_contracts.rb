class AddEndDateToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :end_date, :timestamp
  end
end
