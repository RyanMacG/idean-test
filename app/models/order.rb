class Order < ApplicationRecord
  belongs_to :from_currency, class_name: 'Currency'
  belongs_to :to_currency, class_name: 'Currency'

  validates_numericality_of :amount_purchased, :conversion_rate
  validates_presence_of :denominations
end
