Rails.application.routes.draw do

  root 'static_pages#top'
  get '/signup', to: 'users#new'#ユーザー登録ページを表示
  get "up", to: "rails/health#show", as: :rails_health_check

  #ログイン機能
  get '/login', to: 'sessions#new'#ログインフォームを表示
  post '/login', to: 'sessions#create'#ログイン処理を行う
  delete '/logout', to: 'sessions#destroy'

  resources :users
end
