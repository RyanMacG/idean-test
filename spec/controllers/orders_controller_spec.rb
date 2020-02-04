require 'rails_helper'

RSpec.describe OrdersController, type: :request do
  describe 'GET #index' do
    before do
      create_list(:order, 2)
      get '/api/v1/orders'
    end

    it 'returns the orders' do
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    before do
      @conversion_rate = create(:conversion_rate)
        create(
          :denomination,
          currency_id: @conversion_rate.to_currency_id,
          amount: 200,
          stock: 3
        )
        create(
          :denomination,
          currency_id: @conversion_rate.to_currency_id,
          amount: 100,
          stock: 2
        )
        create(
          :denomination,
          currency_id: @conversion_rate.to_currency_id,
          amount: 50,
          stock: 4
        )
      post '/api/v1/orders', params: { order: params }
    end

    context 'with valid params' do
      let(:params) do
        {
          desired_amount: 1000,
          from_currency_id: @conversion_rate.from_currency_id,
          to_currency_id: @conversion_rate.to_currency_id
        }
      end

      it 'returns the order' do
        expect(JSON.parse(response.body)['order']['amount_purchased']).to eq(1000)
        expect(JSON.parse(response.body)['order']['denominations']).to eq(
          [
            '{:value=>200, :amount=>3}',
            '{:value=>100, :amount=>2}',
            '{:value=>50, :amount=>4}'
          ]
        )
      end

      it 'decreases the stock of the used denominations' do
        expect(Denomination.all.map(&:stock)).to eq([0, 0, 0])
      end

      it 'returns http success' do
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'POST #preview' do
    before do
      @conversion_rate = create(:conversion_rate)
        create(
          :denomination,
          currency_id: @conversion_rate.to_currency_id,
          amount: 200,
          stock: 3
        )
        create(
          :denomination,
          currency_id: @conversion_rate.to_currency_id,
          amount: 100,
          stock: 2
        )
        create(
          :denomination,
          currency_id: @conversion_rate.to_currency_id,
          amount: 50,
          stock: 4
        )
      post '/api/v1/orders/preview', params: { order: params }
    end

    context 'with valid params' do
      let(:params) do
        {
          desired_amount: 1000,
          from_currency_id: @conversion_rate.from_currency_id,
          to_currency_id: @conversion_rate.to_currency_id
        }
      end

      it 'returns the preview order details' do
        expect(JSON.parse(response.body)['order_preview']['amount_available']).to eq(1000)
        expect(JSON.parse(response.body)['order_preview']['denominations']).to eq(
          [
            '{:value=>200, :amount=>3}',
            '{:value=>100, :amount=>2}',
            '{:value=>50, :amount=>4}'
          ]
        )
      end

      it 'does not decrease the stock of the used denominations' do
        expect(Denomination.all.map(&:stock)).to eq([3, 2, 4])
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
