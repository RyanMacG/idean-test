require 'rails_helper'

RSpec.describe ConversionRate, type: :model do
  context 'create' do
    context 'with valid attributes' do
      let(:conversion_rate) { build(:conversion_rate) }

      it 'returns valid' do
        expect(conversion_rate).to be_valid
      end
    end

    context 'with invalid attributes' do
      let(:conversion_rate) { build(:conversion_rate, rate: nil, from_currency: nil, to_currency: nil) }

      it 'returns invalid' do
        expect(conversion_rate).to_not be_valid
        expect(conversion_rate.errors.count).to eq(3)
      end
    end

    context 'with duplicate attributes' do
      let(:orig_conversion_rate) { create(:conversion_rate) }
      let(:dup_conversion_rate) { 
        build(:conversion_rate, from_currency: orig_conversion_rate.from_currency, to_currency: orig_conversion_rate.to_currency)
      }

      it 'returns invalid' do
        expect(dup_conversion_rate).to_not be_valid
      end
    end
  end
end
