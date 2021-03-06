class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  has_many :cars_rentals
  has_many :rentals, through: :car_rentals
end
