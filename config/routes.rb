Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  # get 'tweet', to: 'tweet#tweet'
  get 'oauth/callback', to: 'oauth2_tweets#callback'

  resources :photos, only: [:index, :new, :create] do
    get 'tweet', to: 'tweet_api#tweet'
  end
  root to: 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end