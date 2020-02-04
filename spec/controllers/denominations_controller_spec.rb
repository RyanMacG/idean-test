require 'rails_helper'

RSpec.describe DenominationsController, type: :request do
  describe 'GET #index' do
    before do
      create(:denomination)
      get '/api/v1/denominations'
    end

    it 'returns the denominations' do
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'post #create' do
    before do
      post '/api/v1/denominations', params: params
    end

    context 'with valid params' do
      let(:currency) { create(:currency)}
      let(:params) { { denomination: { amount: 20, stock: 15, currency_id: currency.id } } }

      it 'returns the denomination' do
        expect(JSON.parse(response.body)['denomination']['amount']).to eq(20)
        expect(JSON.parse(response.body)['denomination']['stock']).to eq(15)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:created)
      end

      it 'persists the denomination' do
        expect(Denomination.count).to eq(1)
      end
    end

    context 'with invalid params' do
      let(:params) { { denomination: { amount: '', stock: '' } } }

      it 'returns the error' do
        expect(JSON.parse(response.body)['errors']).to include(
          'amount' => ["is not a number"]
        )
        expect(JSON.parse(response.body)['errors']).to include(
          'stock' => ["is not a number"]
        )
        expect(JSON.parse(response.body)['errors']).to include(
          'currency' => ["must exist"]
        )
      end

      it 'returns http unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'post #update' do
    before do
      denomination = create(:denomination)
      put "/api/v1/denominations/#{denomination.id}", params: params
    end

    context 'with valid params' do
      let(:params) { { denomination: { amount: '5', stock: '3' } } }

      it 'returns the updated denomination' do
        expect(JSON.parse(response.body)['denomination']['amount']).to eq(5)
        expect(JSON.parse(response.body)['denomination']['stock']).to eq(3)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #show' do
    before do
      get "/api/v1/denominations/#{denomination.id}"
    end

    let(:denomination) { create(:denomination) }

    it 'returns the denominations' do
      expect(JSON.parse(response.body)['denomination']['amount']).to eq(denomination.amount)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
