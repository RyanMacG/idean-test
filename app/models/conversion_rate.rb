class ConversionRate < ApplicationRecord
  belongs_to :from_currency, class_name: 'Currency'
  belongs_to :to_currency, class_name: 'Currency'
  
  validates_uniqueness_of :from_currency, scope: [:to_currency]
  validates_numericality_of :rate
end
