Rails.application.routes.draw do
  # get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'oauth/callback', to: 'oauth2_tweets#callback'

  resources :photos, only: [:index, :new, :create]
  resources :tweet_api, only: [:create]
  root to: 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end