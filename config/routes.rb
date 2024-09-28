Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/features'
  get 'pages/hero'

  resources :user_sessions, only: %i[new create destroy]

  resources :users, only: %i[show index new create]

  resources :enrolments, only: %i[new create destroy]

  resources :courses do
    resources :lessons
    resources :comments
  end

  scope '/:locale' do
    resources :users
    resources :courses
    resources :lessons
    resources :enrolments
  end
end
