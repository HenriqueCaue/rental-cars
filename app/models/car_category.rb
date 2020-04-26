class CarCategory < ApplicationRecord
  has_many :car_models

  validates :name, uniqueness: {message: 'Nome deve ser único'}
  validates :name, presence: {message: 'Nome não pode ficar em branco'}

  validates :daily_rate, presence: {message: 'Taxa diária não pode ficar em branco'}
  validates :daily_rate, numericality: { greater_than: 0, message: 'Taxa diária deve ser maior que 0'}

  validates :car_insurance, presence: {message: 'Seguro do carro não pode ficar em branco'}
  validates :car_insurance, numericality: { greater_than: 0, message: 'Seguro do carro deve ser maior que 0'}

  validates :third_party_insurance, presence: {message: 'Seguro contra terceiros não pode ficar em branco'}
  validates :third_party_insurance, numericality: { greater_than: 0, message: 'Seguro contra terceiros deve ser maior que 0'}
end
