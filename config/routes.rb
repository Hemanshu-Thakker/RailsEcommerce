Rails.application.routes.draw do

  root 'sessions#new'
  resources :users do 
  	resources :items do
  		resources :orders 
  	end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get 'users/:user_id/items/:id/buy' => 'items#buy'
  post 'users/:user_id/items/:id/buy' => 'items#create'
  get 'users/:user_id/sold' => 'users#sold'
  get 'users/:user_id/orders' => 'users#orders'
  get 'users/:user_id/add_money' => 'users#add_money', as: 'add_money'
  post 'users/:user_id/increment_balance' => 'users#increment_balance', as: 'increment_balance'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get 'login', to: 'sessions#new', as: 'login'
  get 'signup', to: 'users#new', as: 'signup'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
