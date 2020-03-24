# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    context 'when valid Address' do
      subject { build :address }
      it { is_expected.to be_valid }
    end

    context 'when invalid without zipcode' do
      subject { build :address, zipcode: nil }
      it { is_expected.to validate_presence_of(:zipcode) }
    end

    context 'when invalid without street' do
      subject { build :address, street: nil }
      it { is_expected.to validate_presence_of(:street) }
    end

    context 'when invalid without number' do
      subject { build :address, number: nil }
      it { is_expected.to validate_presence_of(:number) }
    end

    context 'when invalid without neighborhood' do
      subject { build :address, neighborhood: nil }
      it { is_expected.to validate_presence_of(:neighborhood) }
    end

    context 'when invalid without neighborhood' do
      subject { build :address, city: nil }
      it { is_expected.to validate_presence_of(:city) }
    end

    context 'when invalid without neighborhood' do
      subject { build :address, state: nil }
      it { is_expected.to validate_presence_of(:state) }
    end
  end
end
