# frozen_string_literal: true

class StoreBuilder
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def create
    ActiveRecord::Base.transaction do
      @address = Address.create(@params[:address])
      return @address if @address.errors.present?

      Store.create(build_store_params)
    end
  end

  def update(store)
    ActiveRecord::Base.transaction do
      @address = store.address
      address = @params[:address]
      @address.update_attributes(address) if address.present?
      store.update_attributes(build_store_params)
    end
  end

  private

  def build_store_params
    {
      name: @params[:name],
      logo: @params[:logo],
      address_id: @address.id
    }
  end
end
