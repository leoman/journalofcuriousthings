Rails.application.routes.draw do

  get "/login" => "sessions#new", as: "sign_in"
  get "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get '/(/:page)', to: 'posts#index', defaults: { page: '0' }, constraints: { page: /[0-9]/ }
  get '/posts/:slug', to: 'posts#show', as: :show
  get 'tags/:tag', to: 'posts#tags', as: :tag

  post 'orders/submit', to: 'orders#submit'
  post 'orders/paypal/create_payment'  => 'orders#paypal_create_payment', as: :paypal_create_payment
  post 'orders/paypal/execute_payment'  => 'orders#paypal_execute_payment', as: :paypal_execute_payment

  resources :posts, only: [:index, :show]
  resources :products, only: [:index]

  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]
  resources :users, controller: "clearance/users", only: [:create] do
    resource :password, controller: "clearance/passwords", only: [:edit, :update]
  end
  
  namespace :admin do
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