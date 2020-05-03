class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, uniqueness: true
  validates :name, :cnpj, :address, presence: true

  validate :cnpj_must_be_valid
  validates :cnpj, length: {is: 18}
  validates :cnpj, format: { with: /\A^\d{2,3}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$\z/, message: "Digite os pontos, a barra e o traço"}

  private
  def cnpj_must_be_valid
    return if CNPJ.valid?(cnpj)
      errors.add(:cnpj)
  end
end
