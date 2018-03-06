class Rental < ApplicationRecord


  belongs_to :user
  belongs_to :vehicle
  belongs_to :local

end
