class Customer < ApplicationRecord
  validates :name, :document, :email, uniqueness: true

  validates :name, :email, :document, presence: true

  validate :cpf_must_be_valid
  validates :document, length: {is: 14}
  validates :document, format: {with: /\d{3}\.\d{3}\.\d{3}\-\d{2}/, message: "Digite os pontos e o traço"}
  
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }


  scope :search, ->(query) { where('name LIKE ?', "%#{query}%")
                                    .or(where(document: query)) }

  #def self.search(query)
  #  where('name LIKE ?', "%#{query}%")
  #end

  private
  def cpf_must_be_valid
    return if CPF.valid?(document, strict: true)
      errors.add(:document)
  end
end
