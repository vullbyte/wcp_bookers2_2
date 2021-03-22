Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'about', to: 'homes#about'
  resources :users
  resources :books, only: [:new, :create, :index, :show, :destroy]
end