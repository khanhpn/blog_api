Rails.application.routes.draw do
  resources :jobs
  root "tasks#index"
  resources :tasks

  post "tasks/:id/toggle", to: "tasks#toggle"

  mount Api::Root => '/'
  unless Rails.env.test?
    mount GrapeSwaggerRails::Engine, at: '/docs'
  end
end
