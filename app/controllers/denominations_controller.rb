class DenominationsController < ApplicationController
  def index
    render json: Denomination.all
  end

  def create
    denomination = Denomination.create(denomination_params)

    if denomination.valid?
      render json: { denomination: denomination }, status: :created
    else
      render json: { errors: denomination.errors }, status: :unprocessable_entity
    end
  end

  def update
    denomination = Denomination.find_by(id: params[:id])
    if denomination.update(denomination_params)
      render json: { denomination: denomination }
    else
      render json: { errors: denomination.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: { denomination: Denomination.find_by(id: params[:id]) }
  end

  private

  def denomination_params
    params.require(:denomination).permit(:amount, :stock, :currency_id)
  end
end
