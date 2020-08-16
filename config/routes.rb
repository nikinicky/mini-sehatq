Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'register', to: 'users#create', as: 'create_user'
      post 'login', to: 'sessions#login'
      post 'logout', to: 'sessions#logout'

      resources :hospitals, only: [:index]

      resources :orders, only: [:create] do
        member do
          post 'checkout', to: 'orders#checkout'
        end
      end

      resources :doctors, only: [:index] do
        member do
          get 'schedules', to: 'doctors#schedules'
          get 'appointments', to: 'doctors#appointments'
        end
      end
    end
  end
end
