Rails.application.routes.draw do

  get "/login" => "sessions#new", as: "sign_in"
  get "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get '/(/:page)', to: 'posts#index', as: 'home', defaults: { page: '0' }, constraints: { page: /[0-9]/ }
  get '/products/category/:category(/:page)', to: 'products#category', as: 'products_category', defaults: { page: '0' }, constraints: { page: /[0-9]/ }
  get '/products(/:page)', to: 'products#index', as: 'products', defaults: { page: '0' }, constraints: { page: /[0-9]/ }
  get '/posts/:slug', to: 'posts#show', as: :post_show
  get '/products/:slug', to: 'products#show', as: :product_show
  get 'tags/:tag', to: 'posts#tags', as: :tag

  get 'orders/details/:slug' => 'orders#details', as: :orders_details
  post 'orders/create' => 'orders#create', as: :orders_create
  get 'orders/checkout/:order_id' => 'orders#checkout', as: :orders_checkout
  patch 'orders/submit', to: 'orders#submit'
  patch 'orders/paypal/create_payment'  => 'orders#paypal_create_payment', as: :paypal_create_payment
  post 'orders/paypal/execute_payment'  => 'orders#paypal_execute_payment', as: :paypal_execute_payment

  resources :posts, only: [:index, :show]
  resources :products, only: [:index]

  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]
  resources :users, controller: "clearance/users", only: [:create] do
    resource :password, controller: "clearance/passwords", only: [:edit, :update]
  end
  
  namespace :admin do
    get '/', to: redirect('/admin/posts')
    get '/posts/page/(/:page)', to: 'posts#index', defaults: { page: '0' }, constraints: { page: /[0-9]/ }, as: :paginated
    resources :tags, :themes, :orders
    resources :posts, :products do
      member do
        get :preview
        delete :delete_image_attachment
      end
    end
  end

  root 'posts#index'
end