# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    render json: { data: Product.page(params[:page]).order('created_at DESC') }
  end

  def show
    render json: Product.find(params[:id])
  end

  def create
    data = Product.create(resource_params)
    return render_json_validation_error(data) if data.errors.present?

    render json: data, status: :created
  end

  def update
    data = Product.find(params[:id])
    updated = data.update_attributes(resource_params)
    return render_json_validation_error(data) unless updated

    render json: data, status: :ok
  end

  def destroy
    data = Product.find(params[:id])
    data.delete
    render json: { message: 'Resource deleted with success' }, status: :ok
  end

  private

  def resource_params
    params.permit(:name, :description, :price, :cost_price)
  end
end
