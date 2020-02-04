FactoryBot.define do
  factory :order do
    from_currency
    to_currency
    conversion_rate { 2 }
    amount_purchased { 1000 }
    denominations {
      [
        { value: 200, amount: 3},
        { value: 100, amount: 2},
        { value: 50, amount: 4 }
      ]
    }
  end
end
