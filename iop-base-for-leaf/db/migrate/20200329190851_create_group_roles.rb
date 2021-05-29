class CreateGroupRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :group_roles do |t|
      t.references :group, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
