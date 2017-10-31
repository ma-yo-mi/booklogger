Rails.application.routes.draw do

  devise_for :users
  root    'books#index'

  resources :users, only: [:show, :create] do
    resources :reviews, only: [:create]
  end



  resources :books, only: [:index, :show] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    collection do
      get 'search_result'
    end
  end
  
  resources :databases do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    collection do
      get 'search_result'
    end
  end
end
