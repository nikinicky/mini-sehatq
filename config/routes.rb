Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'register', to: 'users#create', as: 'create_user'
    end
  end
end
