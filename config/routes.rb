Rails.application.routes.draw do

  get '/(/:page)', to: 'posts#index', defaults: { page: '0' }, constraints: { page: /[0-9]/ }
  get '/posts/:slug', to: 'posts#show', as: :show
  get 'tags/:tag', to: 'posts#tags', as: :tag

  resources :posts, only: [:index, :show]
  resources :products, only: [:index]

   
  
  namespace :admin do
    get '/posts/page/(/:page)', to: 'posts#index', defaults: { page: '0' }, constraints: { page: /[0-9]/ }, as: :paginated
    resources :tags, :products, :posts do
      member do
        get :preview
      end
    end
  end

  root 'posts#index'
end