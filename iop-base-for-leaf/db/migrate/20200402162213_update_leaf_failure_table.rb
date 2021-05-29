class UpdateLeafFailureTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :leaf_failures, :error_id, :integer
    remove_column :leaf_failures, :error_date, :date
    remove_column :leaf_failures, :error_time, :times
    add_column :leaf_failures, :error_datetime, :datetime
  end
end
