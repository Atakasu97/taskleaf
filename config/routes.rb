Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end
  root to: 'static_pages#home'
  resources :tasks
  get 'static_pages/home'
  get 'static_pages/help'
end
