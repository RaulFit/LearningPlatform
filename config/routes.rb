Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/features'
  get 'pages/hero'

  resources :user_sessions, only: %i[new create destroy]

  resources :users, only: %i[show index new create] do
    resources :authored_courses, only: :index
    resources :available_courses, only: :index
    resources :enroled_courses, only: :index
  end

  resources :courses do
    resources :lessons
    resources :comments
    resources :enrolments
  end
end
