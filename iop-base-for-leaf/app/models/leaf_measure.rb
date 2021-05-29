class LeafMeasure < ApplicationRecord
  belongs_to :leaf_failure
  belongs_to :leaf_measure_type
end
