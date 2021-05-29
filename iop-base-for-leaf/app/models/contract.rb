class Contract < ApplicationRecord
  has_many :assigned_sensors
  validates :contract_id, presence: true, uniqueness: true 
end
