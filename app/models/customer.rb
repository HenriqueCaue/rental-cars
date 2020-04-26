class Customer < ApplicationRecord
  validates :name, uniqueness: {message: 'Nome deve ser único'}
  validates :name, presence: {message: 'Nome não pode ficar em branco'}

  validates :document, uniqueness: {message: 'CPF deve ser único'}
  validates :document, presence: {message: 'CPF não pode ficar em branco'}
  validate :cpf_must_be_valid
  #validates :document, length: {is: 14, message: 'Digite os pontos e o traço'}
  #validates :document, format: {with: /\d{3}\.\d{3}\.\d{3}\-\d{2}/}

  validates :email, uniqueness: {message: 'Email deve ser único'}
  validates :email, presence: {message: 'Email não pode ficar em branco'}

  private
  def cpf_must_be_valid
    return if CPF.valid?(document, strict: true)
      errors.add(:document, 'CPF não é válido')
  end
end
