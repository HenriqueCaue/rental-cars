class CarCategory < ApplicationRecord
  has_many :car_models
  has_many :cars, through: :car_models 

  validates :name, uniqueness: true

  validates :name, :daily_rate, :car_insurance, :third_part_insurance, presence: true

  validates :daily_rate, :car_insurance, :third_part_insurance, numericality: { greater_than: 0}
end
