Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/features'
  get 'pages/hero'
  get 'courses/mycourses'
  resources :user_sessions, only: %i[new create destroy]
  resources :users, only: %i[show index new create]
  resources :registrations, only: %i[new create destroy]
  resources :courses do
    resources :lessons
    resources :comments
  end
end
