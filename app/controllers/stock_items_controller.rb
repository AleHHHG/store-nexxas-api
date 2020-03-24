# frozen_string_literal: true

class StockItemsController < ApplicationController
  before_action :set_stock_item, only: %i[add sub]

  def create
    data = StockItem.create(resource_params)
    return render_json_validation_error(data) if data.errors.present?

    render json: data, status: :created
  end

  def add
    data = StockItemBuilder.new(@stock_item, resource_params, :add).perform
    return render_json_validation_error(data) if data.errors.present?

    render json: data, status: :ok
  end

  def sub
    data = StockItemBuilder.new(@stock_item, resource_params, :sub).perform
    return render_json_validation_error(data) if data.errors.present?

    render json: data, status: :ok
  end

  def set_stock_item
    @stock_item = StockItem.find_by(
      product_id: resource_params[:product_id],
      store_id: resource_params[:store_id]
    )
    return render_json_error(:not_found, 'Not found') if @stock_item.nil?
  end

  private

  def resource_params
    params.permit(:product_id, :store_id, :stock, :qtd)
  end
end
