Rails.application.routes.draw do

  default_url_options :host => "localhost", :port => "3000"

  root 'sessions#new'
  resources :users do
    resources :carts
  	resources :items do
      resources :cart_orders
  		resources :orders
      resources :comments
  	end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get 'users/:user_id/items/:id/buy' => 'items#buy'
  post 'users/:user_id/items/:id/buy' => 'items#create'
  get 'users/:user_id/sold' => 'users#sold'
  get 'users/:user_id/orders' => 'users#orders'
  get 'users/:user_id/add_money' => 'users#add_money', as: 'add_money'
  get 'users/:user_id/your_items' => 'users#your_items', as: 'your_items'
  post 'users/:user_id/increment_balance' =>'users#increment_balance' , as: 'increment_balance'
  post 'users/:user_id/search' => 'items#search', as: 'search'
  get 'users/:user_id/search' => 'items#search'
  get 'password_reset/:id' => 'sessions#password_reset', as: 'password_reset'
  get 'get_user' => 'sessions#get_user'
  post 'validate_user' => 'sessions#validate_user'
  get 'validate_user' => 'sessions#validate_user'
  get 'update_password/:id' => 'sessions#update_password'
  post 'update_password/:id' => 'sessions#update_password', as: 'update_password'
  get 'email_validate/:id' => 'sessions#email_validate', as: 'email_validate'
  get 'remove_item/:id/:key' => 'carts#remove_item', as: 'remove_item'
  post 'buyall' => 'carts#buyall'
  get 'users/:user_id/cart_orders' => 'cart_orders#show', as: 'order_confirmation'

  # cart_orders
  # post 'users/:user_id/cart_orders/:item_id' => 'cart_orders#create'
  # get 'users/:user_id/cart_orders/:item_id' => 'cart_orders#index', as: 'user_cart_order'
  # get 'users/:user_id/cart_orders' => 'cart_orders#show', as: 'user_cart_orders'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get 'login', to: 'sessions#new', as: 'login'
  get 'signup', to: 'users#new', as: 'signup'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
