# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    context 'when valid Product' do
      subject { build :product }
      it { is_expected.to be_valid }
    end

    context 'when invalid without name' do
      subject { build :product, name: nil }
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'when invalid without price' do
      subject { build :product, price: nil }
      it { is_expected.to validate_presence_of(:price) }
    end

    context 'when invalid without cost_price' do
      subject { build :product, cost_price: nil }
      it { is_expected.to validate_presence_of(:cost_price) }
    end
  end
end
