Rails.application.routes.draw do

  get 'posts/(/:page)', to: 'posts#index', defaults: { page: '0' }, constraints: { page: /[0-9]/ }
  resources :posts, only: [:index]
  resources :products, only: [:index]
  
  
  namespace :admin do
    resources :products, :posts do
      member do
        get :preview
      end
    end
  end

  # get '/admin/products', to: 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end