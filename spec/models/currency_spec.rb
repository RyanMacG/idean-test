require 'rails_helper'

RSpec.describe Currency, type: :model do
  context 'create' do
    context 'with valid attributes' do
      let(:currency) { build(:currency) }

      it 'returns valid' do
        expect(currency).to be_valid
      end
    end

    context 'with invalid attributes' do
      let(:currency) { build(:currency, name: '', short_code: '') }

      it 'returns invalid' do
        expect(currency).to_not be_valid
        expect(currency.errors.count).to eq(2)
      end
    end

    context 'with duplicate attributes' do
      before { create(:currency, short_code: 'USD') }
      let(:dup_currency) { build(:currency, short_code: 'USD') }

      it 'returns invalid' do
        expect(dup_currency).to_not be_valid
      end
    end
  end
end
