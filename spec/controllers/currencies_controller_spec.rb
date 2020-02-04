require 'rails_helper'

RSpec.describe CurrenciesController, type: :request do
  describe 'GET #index' do
    before do
      create(:currency)
      get '/api/v1/currencies'
    end

    it 'returns the currencies' do
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'post #create' do
    before do
      post '/api/v1/currencies', params: params
    end

    context 'with valid params' do
      let(:params) { { currency: { name: 'US Dollars', short_code: 'USD' } } }

      it 'returns the currency' do
        expect(JSON.parse(response.body)['currency']['name']).to eq('US Dollars')
        expect(JSON.parse(response.body)['currency']['short_code']).to eq('USD')
      end

      it 'returns http success' do
        expect(response).to have_http_status(:created)
      end

      it 'persists the currency' do
        expect(Currency.count).to eq(1)
      end
    end

    context 'with invalid params' do
      let(:params) { { currency: { name: '', short_code: '' } } }

      it 'returns the error' do
        expect(JSON.parse(response.body)['errors']).to include(
          'name' => ["can't be blank"]
        )
        expect(JSON.parse(response.body)['errors']).to include(
          'short_code' => ["can't be blank"]
        )
      end

      it 'returns http unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'post #update' do
    before do
      currency = create(:currency)
      put "/api/v1/currencies/#{currency.id}", params: params
    end

    context 'with valid params' do
      let(:params) { { currency: { name: 'US Dollars', short_code: 'USD' } } }

      it 'returns the updated currency' do
        expect(JSON.parse(response.body)['currency']['name']).to eq('US Dollars')
        expect(JSON.parse(response.body)['currency']['short_code']).to eq('USD')
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #show' do
    before do
      get "/api/v1/currencies/#{currency.id}"
    end

    let(:currency) { create(:currency) }

    it 'returns the currencies' do
      expect(JSON.parse(response.body)['currency']['name']).to eq(currency.name)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
