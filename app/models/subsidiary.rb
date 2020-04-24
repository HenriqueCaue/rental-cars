class Subsidiary < ApplicationRecord
  validates :name, uniqueness: {message: 'Nome deve ser único'}
  validates :name, presence: {message: 'Nome não pode ficar em branco'}

  validates :cnpj, uniqueness: {message: 'CNPJ deve ser único'}
  validates :cnpj, presence: {message: 'CNPJ não pode ficar em branco'}
  validate :cnpj_must_be_valid

  validates :address, uniqueness: {message: 'Endereço deve ser único'}
  validates :address, presence: {message: 'Endereço não pode ficar em branco'}

  private
  def cnpj_must_be_valid
    return if CNPJ.valid?(cnpj)
      errors.add(:cnpj, 'não é válido')
  end
end
