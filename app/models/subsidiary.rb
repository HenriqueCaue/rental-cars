class Subsidiary < ApplicationRecord
  validates :name, uniqueness: {message: 'Nome deve ser único'}
  validates :name, presence: {message: 'Nome não pode ficar em branco'}

  validates :cnpj, uniqueness: {message: 'CNPJ deve ser único'}
  validates :cnpj, presence: {message: 'CNPJ não pode ficar em branco'}

  validates :address, uniqueness: {message: 'Endereço deve ser único'}
  validates :address, presence: {message: 'Endereço não pode ficar em branco'}
end
