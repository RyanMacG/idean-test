class ConversionRatesController < ApplicationController
  def index
    render json: ConversionRate.all
  end

  def create
    conversion_rate = ConversionRate.create(conversion_rate_params)

    if conversion_rate.valid?
      render json: { conversion_rate: conversion_rate }, status: :created
    else
      render json: { errors: conversion_rate.errors }, status: :unprocessable_entity
    end
  end

  def update
    conversion_rate = ConversionRate.find_by(id: params[:id])

    if conversion_rate.update(conversion_rate_params)
      render json: { conversion_rate: conversion_rate }, status: :created
    else
      render json: { errors: conversion_rate.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: { conversion_rate: ConversionRate.find_by(id: params[:id]) }
  end

  private

  def conversion_rate_params
    params.require(:conversion_rate).permit(:rate, :from_currency_id, :to_currency_id)
  end
end
