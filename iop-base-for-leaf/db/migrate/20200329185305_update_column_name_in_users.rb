class UpdateColumnNameInUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :role, :site_role
  end
end
