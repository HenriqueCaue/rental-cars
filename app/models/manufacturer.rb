class Manufacturer < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true
end
