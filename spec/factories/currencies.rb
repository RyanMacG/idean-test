FactoryBot.define do
  factory :currency, aliases: %i[from_currency to_currency] do
    name { Faker::Currency.name }
    short_code { Faker::Currency.code }
  end
end
