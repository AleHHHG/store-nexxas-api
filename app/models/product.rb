# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, :price, :cost_price, presence: true
  has_many :stok_items
  has_many :stores, through: :stok_items
end
