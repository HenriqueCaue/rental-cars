FactoryBot.define do
  factory :subsidiary do
    sequence(:name) { |n| "São paulo#{n}" }
    cnpj { CNPJ.generate(formated: true) }
    sequence(:address) { |n| "Rua Joa de Barro#{n}" }
  end
end