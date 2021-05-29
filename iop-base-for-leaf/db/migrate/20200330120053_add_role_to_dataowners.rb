class AddRoleToDataowners < ActiveRecord::Migration[5.2]
  def change
    add_column :data_owners, :role, :string, default: "memeber"
  end
end
