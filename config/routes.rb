Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/features'
  get 'pages/hero'
  get 'user_courses/mycourses'
  get 'user_courses/explore'
  resources :user_sessions, only: %i[new create destroy]
  resources :users, only: %i[show index new create]
  resources :courses do
    resources :lessons
    resources :comments
    resources :registrations, only: %i[new create destroy]
  end
end
