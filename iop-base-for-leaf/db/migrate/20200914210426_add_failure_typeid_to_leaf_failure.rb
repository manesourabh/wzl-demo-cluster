class AddFailureTypeidToLeafFailure < ActiveRecord::Migration[5.2]
  def change
    add_reference :leaf_failures, :leaf_failure_type, foreign_key: true
  end
end
