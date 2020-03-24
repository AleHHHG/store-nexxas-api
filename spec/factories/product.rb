# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'Teste' }
    description { 'Teste description' }
    price { 199_90 }
    cost_price { 89_99 }
  end
end
