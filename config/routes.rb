Rails.application.routes.draw do

  resources :homes
  resources :products do
    resources :ratings, except:[:show, :index]
  end
  resources :categories
  resource :card, only:[:show]
  resources :order_items
  devise_for :users

  get 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  #get 'products/show_cart', to: 'products#show_cart', as: 'show_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  root 'products#index'
  get 'home/index'
  get 'search', to: 'products#index'
  #get '/homes/:id', to: 'homes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
