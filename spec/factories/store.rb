# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    name { 'Teste' }
    address { create(:address) }
  end
end
