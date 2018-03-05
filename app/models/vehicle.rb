class Vehicle < ApplicationRecord
  validates :local_id,presence: true ,on: :update , if: :max_vehicles

belongs_to :local
has_many :rental
def max_vehicles

local= Local.find(self.local_id)
if local.max.to_i < local.vehicle.count+1
  p 'nope'
false
else
  p 'okay'
true
end
end
end
