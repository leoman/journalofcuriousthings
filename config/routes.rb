Rails.application.routes.draw do
  # resources :widgets
  # resources :products

  namespace :admin do
    resources :products, :posts
  end

  # get '/admin/products', to: 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end