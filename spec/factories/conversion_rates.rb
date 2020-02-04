FactoryBot.define do
  factory :conversion_rate do
    rate { 2.0 }
    from_currency
    to_currency
  end
end
