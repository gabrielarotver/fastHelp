Rails.application.routes.draw do
  resources :events
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'organizations#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :organizations
  get 'page/index'
  root 'page#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
