Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root 'posts#index'

  devise_for :users

  resources :users, only: %i[index show]
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end

  resources :friendships, only: %i[create destroy update]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[create]
      resources :posts, only: %i[index show create] do
        resources :comments, only: %i[index create]
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
