Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get '/home/about', to: 'homes#about'
  resources :users do
    member do
     get :followed, :followers
    end
  end
  get 'search' => 'searches#search'
  resources :relationships, only: [:create, :destroy]

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
end
