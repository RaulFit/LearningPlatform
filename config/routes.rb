Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/hero'

  resources :user_sessions, only: %i[new create destroy]

  resources :users, only: %i[show index new create]

  resources :courses do
    resources :course_lessons, only: %i[update destroy]
    resources :enrolments, only: %i[new create destroy update]
    resources :lessons do
      resources :comments
    end
  end

  
  resources :tags
end
