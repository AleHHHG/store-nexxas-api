# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    context 'when valid Store' do
      subject { build :store }
      it { is_expected.to be_valid }
    end

    context 'when invalid without name' do
      subject { build :store, name: nil }
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'when invalid without address' do
      subject { build :store, address_id: nil }
      it { is_expected.to belong_to(:address) }
    end
  end
end
