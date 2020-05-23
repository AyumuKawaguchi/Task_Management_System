Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  
  root to: 'tasks#index'
  resources :tasks
  resources :users
 
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # なぜログイン表示（サインイン）にnewアクションが使われるか？という疑問があったが、そういうものだという理解にしとくのが良い。
  # createアクションでログインを実行
end
