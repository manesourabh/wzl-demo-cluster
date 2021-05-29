class LeafFailureType < ApplicationRecord
  has_many :measure_types, class_name: "LeafMeasureType"
  has_many :failures, class_name: "LeafFailuer"
end
