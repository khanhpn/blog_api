Rails.application.routes.draw do
  resources :jobs
  resources :tasks
  root "tasks#index"
  resources :messages
end
