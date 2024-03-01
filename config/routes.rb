Rails.application.routes.draw do
  post '/login', to: 'sessions#create'
  resources :todos
  resources :users, only: [:create]

  get '/my_todos', to: 'todos#my_todos'
end
