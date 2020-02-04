class Order < ApplicationRecord
  belongs_to :from_currency, class_name: 'Currency'
  belongs_to :to_currency, class_name: 'Currency'

  validates_numericality_of :amount_purchased, :conversion_rate
  validates_presence_of :denominations

  def self.conversion_details(order_params, is_preview? = false)
    conversion_rate = retrieve_conversion_rate(order_params)
    value, denominations = calculate_conversion(conversion_rate, order_params)

    {
      amount_purchased: value,
      from_currency_id: conversion_rate.from_currency_id,
      to_currency_id: conversion_rate.to_currency_id,
      conversion_rate: conversion_rate.rate,
      denominations: denominations
    }
  end

  private

  def self.retrieve_conversion_rate(order_params)
    ConversionRate.find_by(
      from_currency: order_params[:from_currency_id],
      to_currency: order_params[:to_currency_id]
    )
  end

  def self.calculate_conversion(conversion_rate, order_params)
    amount_desired = order_params[:desired_amount].to_i
    denominations = Denomination.where(currency: conversion_rate.to_currency).where.not(stock: 0)
    total_available = denominations.sum(&:total_available)
    denomination_stock_used = []

    if amount_desired == total_available
      value = amount_desired
      denominations.map do |d|
        denomination_stock_used << { value: d.amount, amount: d.stock }
        d.update_attribute(:stock, 0) unless is_preview?
      end
    else
      # couldn't work out the more complicated scenario in the allotted time
    end

    return value, denomination_stock_used
  end
end
