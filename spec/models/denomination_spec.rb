require 'rails_helper'

RSpec.describe Denomination, type: :model do
  context 'create' do
    context 'with valid attributes' do
      let(:denomination) { build(:denomination) }

      it 'returns valid' do
        expect(denomination).to be_valid
      end
    end

    context 'with invalid attributes' do
      let(:denomination) { build(:denomination, amount: nil, stock: nil, currency: nil) }

      it 'returns invalid' do
        expect(denomination).to_not be_valid
        expect(denomination.errors.count).to eq(3)
      end
    end

    context 'with duplicate attributes' do
      let(:orig_denomination) { create(:denomination) }
      let(:dup_denomination) { 
        build(:denomination, currency: orig_denomination.currency)
      }

      it 'returns invalid' do
        expect(dup_denomination).to_not be_valid
      end
    end
  end
end
