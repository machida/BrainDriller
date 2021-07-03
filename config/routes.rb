Rails.application.routes.draw do
  root "drills#index"

  draw :api

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :drills do
    resources :problems, only: [:index], controller: "drills/problems"
  end

  resources :problems
  get 'edit_profile', to: 'users#edit_profile', as: "edit_profile"
  get 'favorite-problems', to: 'problems#favorite'
  get 'mydrills', to: 'drills#mydrills'
  get 'solve/:id', to: 'drills#solve', as: "solve"

  resources :drill_likes, only: [:create, :destroy]

  resources :users, only: %i[index show new create edit] do
    resources :solve
  end

  get "tos" => "static_pages#tos"
  get "policy" => "static_pages#policy"
end
