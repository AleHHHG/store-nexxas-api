# frozen_string_literal: true

class Store < ApplicationRecord
  validates :name, presence: true
  belongs_to :address
  has_many :stok_items
  has_many :products, through: :stok_items
end
