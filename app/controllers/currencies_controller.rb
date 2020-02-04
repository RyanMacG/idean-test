class CurrenciesController < ApplicationController
  def index
    render json: Currency.all
  end

  def create
    currency = Currency.create(currency_params)

    if currency.valid?
      render json: { currency: currency }, status: :created
    else
      render json: { errors: currency.errors }, status: :unprocessable_entity
    end
  end

  def update
    currency = Currency.find_by(id: params[:id])
    if currency.update(currency_params)
      render json: { currency: currency }
    else
      render json: { errors: currency.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: { currency: Currency.find_by(id: params[:id]) }
  end

  private

  def currency_params
    params.require(:currency).permit(:name, :short_code)
  end
end
