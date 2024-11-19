Rails.application.routes.draw do
  # トップページのルーティング
  root 'welcome#index'

  # ユーザーセッションのルーティング
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create', as: :create_session
  delete '/logout', to: 'sessions#destroy', as: :logout

  # ユーザー関連のルーティング
  resources :users, only: [:new, :create, :show, :edit, :update]
  resource :account, only: [:show, :edit, :update], controller: 'users'

  # レシピ関連のルーティング
  # resources :recipes do
  #   collection do
  #     get :search  # ここで search アクションを定義
  #   end
  # end
  resources :recipes, only: [:new, :create, :show]

  # その他のルーティング
  get 'home/index', to: 'home#index', as: :home
  get '/confirm_email', to: 'users#confirm_email', as: :confirm_email
end

