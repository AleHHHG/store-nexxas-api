# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    zipcode { '00000-000' }
    street { 'Street test' }
    number { 1 }
    neighborhood { 'neighborhood test' }
    city { 'City test' }
    state { 'State test' }
  end
end
