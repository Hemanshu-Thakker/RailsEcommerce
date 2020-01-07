Rails.application.routes.draw do
  root 'users#index'
  resources :users do 
  	resources :items do
  		resources :orders 
  	end
  end

  get 'users/:user_id/items/:id/buy' => 'items#buy'
  post 'users/:user_id/items/:id/buy' => 'items#create'
  get 'users/:user_id/sold' => 'users#sold'
  get 'users/:user_id/orders' => 'users#orders'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
