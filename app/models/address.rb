# frozen_string_literal: true

class Address < ApplicationRecord
  validates :zipcode, :street, :number, :neighborhood,
            :city, :state, presence: true
  has_many :stores
end
