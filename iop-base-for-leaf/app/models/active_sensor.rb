class ActiveSensor < ApplicationRecord
  validates :sensor_name, presence: true, uniqueness: true 
end
