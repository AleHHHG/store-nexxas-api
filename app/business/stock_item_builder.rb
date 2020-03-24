# frozen_string_literal: true

class StockItemBuilder
  attr_reader :params, :action

  ACTIONS = {
    add: '+',
    sub: '-'
  }.freeze

  def initialize(stock_item, params, action)
    @stock_item = stock_item
    @params = params
    @action = action
  end

  def perform
    return validate_qtd_present unless @params[:qtd].present?

    @stock_item.stock = @stock_item.stock.send(
      ACTIONS[@action],
      @params[:qtd].to_i
    )
    @stock_item.save
    @stock_item
  end

  private

  def validate_qtd_present
    @stock_item.errors.add(:base, 'qtd cannot be empty')
    @stock_item
  end
end
