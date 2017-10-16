Rails.application.routes.draw do

  devise_for :users
  resources :books

  get 'signup' => 'user#new'
  root    'books#index'
  # get   'users/:id'   =>  'users#show'

end



  # devise_for :users, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions'
  # }

  # devise_scope :user do
  #   get "sign_in", :to => "users/sessions#new"
  #   get "sign_out", :to => "users/sessions#destroy"
  # end
