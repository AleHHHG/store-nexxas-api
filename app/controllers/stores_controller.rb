# frozen_string_literal: true

class StoresController < ApplicationController
  def index
    render json: {
      data: Store.page(params[:page]).order('created_at DESC')
    }, include: :address
  end

  def show
    render json: Store.find(params[:id]), include: :address
  end

  def create
    data = StoreBuilder.new(resource_params).create
    return render_json_validation_error(data) if data.errors.present?

    render json: data, include: :address, status: :created
  end

  def update
    data = Store.find(params[:id])
    updated = StoreBuilder.new(resource_params).update(data)
    return render_json_validation_error(data) unless updated

    render json: data, include: :address, status: :ok
  end

  def destroy
    data = Store.find(params[:id])
    data.delete
    render json: { message: 'Resource deleted with success' }, status: :ok
  end

  private

  def resource_params
    params.permit(:name, :logo, address: {})
  end
end
