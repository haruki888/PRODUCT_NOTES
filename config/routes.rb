Rails.application.routes.draw do
  root 'static_pages#top'

  get "up", to: "rails/health#show", as: :rails_health_check

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/delete', to: 'sessions#destroy'

end
