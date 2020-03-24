# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockItem, type: :model do
  describe 'validations' do
    context 'when valid StockItem' do
      subject { build :stock_item }
      it { is_expected.to be_valid }
    end

    context 'when invalid without stock' do
      subject { build :stock_item, stock: nil }
      it { is_expected.to validate_presence_of(:stock) }
    end

    context 'when invalid without product' do
      subject { build :stock_item, product_id: nil }
      it { is_expected.to belong_to(:product) }
    end

    context 'when invalid without store' do
      subject { build :stock_item, store_id: nil }
      it { is_expected.to belong_to(:store) }
    end

    context 'when invalid stock negative' do
      subject { build :stock_item, stock: -10 }
      it {
        subject.valid?
        expect(subject.errors[:stock]).to include('stock cannot be negative')
      }
    end
  end
end
