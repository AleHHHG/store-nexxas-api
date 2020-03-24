# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  let(:body) { JSON.parse(response.body) }
  let(:data) { body['data'] }

  RSpec.shared_examples 'default params' do
    it 'returns response with default values' do
      expect(data).to have_key('name')
      expect(data).to have_key('logo')
      expect(data).to have_key('address_id')
      expect(data).to have_key('address')
      expect(data).to have_key('created_at')
      expect(data).to have_key('updated_at')
    end
  end

  RSpec.shared_examples 'returns http success' do
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET' do
    let!(:store) { create(:store) }
    context '#index' do
      let(:data) { body['data'].first }
      let(:params) { {} }
      before { get :index, params: params }

      it_behaves_like 'default params'
      it_behaves_like 'returns http success'
    end

    context '#show' do
      let(:data) { body }
      let(:params) { { id: store.id } }
      before { get :show, params: params }

      it_behaves_like 'default params'
      it_behaves_like 'returns http success'
    end

    context '#show_not_found' do
      let(:data) { body }
      let(:params) { { id: 0 } }
      before { get :show, params: params }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST' do
    context '#create' do
      let(:params) do
        attributes_for(:store).merge!(
          address: attributes_for(:address)
        )
      end
      before { post :create, params: params }

      it { expect(response).to have_http_status(:created) }
    end

    context '#create_bad_request' do
      let(:data) { body }
      before { post :create, params: {} }

      it { expect(response).to have_http_status(:bad_request) }
      it { expect(data).to have_key('errors') }
    end

    context '#create_without_address' do
      let(:data) { body }
      before { post :create, params: attributes_for(:store) }

      it { expect(response).to have_http_status(:bad_request) }
      it { expect(data).to have_key('errors') }
    end
  end

  describe 'PATCH' do
    let(:store) { create(:store) }
    context '#update' do
      let(:params) do
        { id: store.id, name: 'Teste 1' }
      end
      before { patch :update, params: params }
      it 'change' do
        expect(store.reload.name).to eq('Teste 1')
      end
    end

    context '#update_with_adress' do
      let(:params) do
        { id: store.id, name: 'Teste 1', address: { street: 'Street test 1' } }
      end
      before { patch :update, params: params }
      it 'change' do
        expect(store.reload.name).to eq('Teste 1')
        expect(store.reload.address.street).to eq('Street test 1')
      end
    end
  end

  describe 'DELETE' do
    let(:stores) { create_list(:store, 3) }
    context '#delete' do
      let(:params) do
        { id: stores.first.id }
      end
      before { delete :destroy, params: params }
      it_behaves_like 'returns http success'
    end
  end
end
