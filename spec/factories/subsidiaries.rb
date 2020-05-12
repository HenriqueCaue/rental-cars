FactoryBot.define do
  factory :subsidiary do
    sequence(:name) { |n| "São paulo#{n}" }
    cnpj { CNPJ.generate(formated: true) }
    address { 'Rua Joa de Barro' }
  end
end