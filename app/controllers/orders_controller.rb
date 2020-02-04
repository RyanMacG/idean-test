class OrdersController < ApplicationController
  def index
    render json: Order.all
  end

  def create
    order_details = Order.conversion_details(order_params)
    order = Order.create(order_details)

    if order.valid?
      render json: { order: order }, status: :created
    else
      render json: { errors: order.errors }, status: :unprocessable_entity
    end
  end

  def preview
    order_details = Order.conversion_details(order_params, is_preview: true)
    render json: { order_preview: order_details }
  end

  private

  def order_params
    params
      .require(:order)
      .permit(
        :desired_amount,
        :from_currency_id,
        :to_currency_id
      )
  end
end
