# frozen_string_literal: true

class StockItem < ApplicationRecord
  validates :stock, presence: true
  validate :stock_qtd
  belongs_to :product
  belongs_to :store

  def stock_qtd
    errors.add(:stock, 'stock cannot be negative') if check_stock
  end

  def check_stock
    stock.present? && stock.negative?
  end
end
