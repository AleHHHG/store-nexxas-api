Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products
  resources :stores
  resources :stock_items, only: %i[create] do
    collection do
      put 'add'
      put 'sub'
    end
  end
end
