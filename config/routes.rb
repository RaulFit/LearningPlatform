Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/features'
  get 'pages/hero'
  get 'user_courses/mycourses'
  get 'user_courses/explore'
  get 'user_courses/registrations'

  resources :user_sessions, only: %i[new create destroy]

  resources :users, only: %i[show index new create] do
    resources :authored_courses, only: :index
    resources :enrolments
  end

  resources :courses do
    resources :lessons
    resources :comments
  end
end
