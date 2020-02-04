require 'rails_helper'

RSpec.describe Order,
type: :model do
  describe 'create' do
    context 'with valid details' do
      let(:order) { build(:order) }

      it 'returns valid' do
        expect(order).to be_valid
      end
    end

    context 'with invalid attributes' do
      let(:order) do
        build(
          :order,
          amount_purchased: nil,
          conversion_rate: nil,
          from_currency: nil,
          to_currency: nil,
          denominations: []
        )
      end

      it 'returns invalid' do
        expect(order).to_not be_valid
        expect(order.errors.count).to eq(5)
      end
    end
  end
end
