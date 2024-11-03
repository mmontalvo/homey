Rails.application.routes.draw do
  resources :projects
  resources :messages, only: %i[ new create ]
  devise_for :users

  root "projects#index"
end
