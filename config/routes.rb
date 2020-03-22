Rails.application.routes.draw do
  # resources :widgets

  get 'posts/(/:page)', to: 'posts#index', defaults: { page: '0' }, constraints: { page: /[0-9]/ }
  resources :posts
  
  
  namespace :admin do
    resources :products, :posts
  end

  # get '/admin/products', to: 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end