class CreateLeafFailures < ActiveRecord::Migration[5.2]
  def change
    create_table :leaf_failures do |t|
      t.integer :error_id
      t.references :user, foreign_key: true
      t.date :error_date
      t.time :error_time
      t.string :status
      t.string :description
      t.string :activity
      t.string :failure
      t.string :cause
      t.boolean :recoverable
      t.string :measures

      t.timestamps
    end
    add_index :leaf_failures, :error_id
    add_index :leaf_failures, :status
    add_index :leaf_failures, :activity
  end
end
