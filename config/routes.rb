Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "home#index"
  resources :items, only:[:new, :create, :show]
  resources :categories, only:[:new, :create, :index, :show, :edit, :update]
end
