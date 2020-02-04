class Denomination < ApplicationRecord
  belongs_to :currency
  validates_numericality_of :stock, :amount
  validates_uniqueness_of :amount, scope: [:currency]
end
