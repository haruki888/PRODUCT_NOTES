Rails.application.routes.draw do

  root 'static_pages#top'#ホームページの設定。
  get '/signup', to: 'users#new'#ユーザー登録ページを表示①
  get "up", to: "rails/health#show", as: :rails_health_check

  #ログイン機能
  get '/login', to: 'sessions#new'#ログインフォームを表示②
  post '/login', to: 'sessions#create'#ログイン情報の送信③
  delete '/logout', to: 'sessions#destroy'#ログアウト処理④

  resources :users
end
