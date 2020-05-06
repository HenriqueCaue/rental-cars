class CarModel < ApplicationRecord
  belongs_to :manufacturer
  has_many :cars
  belongs_to :car_category
  
  validates :name, :year, :motorization, :fuel_type, :manufacturer_id, :car_category_id, presence: true

end
