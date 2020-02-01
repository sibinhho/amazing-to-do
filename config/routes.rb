Rails.application.routes.draw do
  post 'auth', to: 'authentication#authenticate'
  get 'search', to: 'v1/tasks#search'

  resources :users
  namespace :v1 do
    resources :tasks
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
