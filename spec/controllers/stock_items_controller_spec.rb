# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockItemsController, type: :controller do
  let(:body) { JSON.parse(response.body) }
  let!(:product) { create(:product) }
  let!(:store) { create(:store) }

  describe 'POST' do
    context '#create' do
      before do
        post :create, params: {
          store_id: store.id, product_id: product.id, stock: 10
        }
      end
      it { expect(response).to have_http_status(:created) }
    end

    context '#create_bad_request' do
      let(:data) { body }
      before { post :create, params: {} }

      it { expect(response).to have_http_status(:bad_request) }
      it { expect(data).to have_key('errors') }
    end
  end

  describe 'PATCH' do
    let(:stock_item) { create(:stock_item) }
    context '#add' do
      before do
        patch :add, params: {
          store_id: stock_item.store_id,
          product_id: stock_item.product_id,
          qtd: 10
        }
      end
      it 'change' do
        expect(response).to have_http_status(:success)
        expect(stock_item.reload.stock).to eq(20)
      end
    end

    context '#add_not_found' do
      before { patch :add, params: { store_id: 0, product_id: 0, qtd: 10 } }
      it 'change' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context '#add_error_qtd' do
      let(:data) { body }
      before { patch :add, params: { store_id: stock_item.store_id, product_id: stock_item.product_id, qtd: nil } }
      it 'change' do
        expect(response).to have_http_status(:bad_request)
        expect(data).to have_key('errors')
      end
    end

    context '#sub' do
      before { patch :sub, params: { store_id: stock_item.store_id, product_id: stock_item.product_id, qtd: 10 } }
      it 'change' do
        expect(response).to have_http_status(:success)
        expect(stock_item.reload.stock).to eq(0)
      end
    end

    context '#add_not_found' do
      before { patch :sub, params: { store_id: 0, product_id: 0, qtd: 10 } }
      it 'change' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context '#add_error_qtd' do
      let(:data) { body }
      before { patch :sub, params: { store_id: stock_item.store_id, product_id: stock_item.product_id, qtd: nil } }
      it 'change' do
        expect(response).to have_http_status(:bad_request)
        expect(data).to have_key('errors')
      end
    end
  end
end
