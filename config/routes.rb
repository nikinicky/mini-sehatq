Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'register', to: 'users#create', as: 'create_user'
      post 'login', to: 'sessions#login'
      post 'logout', to: 'sessions#logout'

      resources :hospitals, only: [:index]
      resources :doctors, only: [:index]
    end
  end
end
