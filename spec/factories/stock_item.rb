# frozen_string_literal: true

FactoryBot.define do
  factory :stock_item do
    product { create(:product) }
    store { create(:store) }
    stock { 10 }
  end
end
