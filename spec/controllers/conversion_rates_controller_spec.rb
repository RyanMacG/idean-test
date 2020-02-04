require 'rails_helper'

RSpec.describe ConversionRatesController, type: :request do
  describe 'GET #index' do
    before do
      create(:conversion_rate)
      get '/api/v1/conversion_rates'
    end

    it 'returns the conversion rates' do
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'post #create' do
    before do
      post '/api/v1/conversion_rates', params: params
    end

    context 'with valid params' do
      let(:from_currency) { create(:currency)}
      let(:to_currency) { create(:currency)}
      let(:params) { { conversion_rate: { rate: 2.5, from_currency_id: from_currency.id, to_currency_id: to_currency.id } } }

      it 'returns the conversion rate' do
        expect(JSON.parse(response.body)['conversion_rate']['rate']).to eq(2.5)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:created)
      end

      it 'persists the conversion rate' do
        expect(ConversionRate.count).to eq(1)
      end
    end

    context 'with invalid params' do
      let(:params) { { conversion_rate: { rate: '', from_currency_id: '', to_currency_id: '' } } }

      it 'returns the error' do
        expect(JSON.parse(response.body)['errors']).to include(
          'rate' => ["is not a number"]
        )
        expect(JSON.parse(response.body)['errors']).to include(
          'to_currency' => ["must exist"]
        )
        expect(JSON.parse(response.body)['errors']).to include(
          'from_currency' => ["must exist"]
        )
      end

      it 'returns http unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'post #update' do
    before do
      conversion_rate = create(:conversion_rate)
      put "/api/v1/conversion_rates/#{conversion_rate.id}", params: params
    end

    context 'with valid params' do
      let(:params) { { conversion_rate: { rate: '16' } } }

      it 'returns the updated conversion_rate' do
        expect(JSON.parse(response.body)['conversion_rate']['rate']).to eq(16)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #show' do
    before do
      get "/api/v1/conversion_rates/#{conversion_rate.id}"
    end

    let(:conversion_rate) { create(:conversion_rate) }

    it 'returns the conversion_rates' do
      expect(JSON.parse(response.body)['conversion_rate']['rate']).to eq(conversion_rate.rate)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
