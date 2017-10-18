Rails.application.routes.draw do

  devise_for :users
  root    'books#index'

  resources :users, only: [:show, :create] do
    resources :reviews, only: [:create]
  end


  resources :books, only: [:index, :show] do
    collection do
      get 'search_result'
    end
  end
end

  # get 'signup' => 'user#new'
  # get   'users/:id'   =>  'users#show'
