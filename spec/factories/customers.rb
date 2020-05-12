FactoryBot.define do
  factory :customer do
    sequence(:name) { |n| "João#{n}" }
    document { CPF.generate(formated: true) }
    sequence(:email) { |n| "customer#{n}@test.com" }
  end
end

