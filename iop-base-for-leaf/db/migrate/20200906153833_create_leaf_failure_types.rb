class CreateLeafFailureTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :leaf_failure_types do |t|
      t.string :activity
      t.string :failure
      t.string :cause
      t.boolean :admin_approval

      t.timestamps
    end
  end
end
