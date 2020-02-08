Rails.application.routes.draw do  
  namespace :v1 do
    get 'search', to: 'tasks#search'
    post 'auth', to: 'authentication#authenticate'
    resources :tasks
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
