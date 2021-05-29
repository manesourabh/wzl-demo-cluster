class LeafMeasureType < ApplicationRecord
  belongs_to :leaf_failure_type
  has_many :leaf_measures
  has_many :leaf_failures, through: :leaf_measures
end
