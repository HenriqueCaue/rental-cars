class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, uniqueness: true
  validates :name, :cnpj, :address, presence: true

  validate :cnpj_must_be_valid

  private
  def cnpj_must_be_valid
    return if CNPJ.valid?(cnpj)
      errors.add(:cnpj)
  end
end
