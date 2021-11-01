Rails.application.routes.draw do
  # Serve websocket cable requests in-process
   #mount ActionCable.server => '/cable'
  
  get'carts/index'
  resources :orders
  #get 'orders/show'
  resources :accounts
  resources :checkouts
  resources :shippings
  resources :homes
  resources :products do
    resources :ratings, except:[:show, :index]
  end
  resources :carts
  resources :categories
  resource :card, only:[:show]
  resources :order_items
  devise_for :users

  post 'carts/update_cart', to: 'carts#update_cart', as: 'update_cart'

  root 'products#index'
  get 'home/index'
  get 'search', to: 'products#index'
  #get '/homes/:id', to: 'homes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
