class Currency < ApplicationRecord
  validates_presence_of :name, :short_code
  validates_uniqueness_of :short_code
end
