Rails.application.routes.draw do
  resources :users do
    resources :goals, only: [:new, :create]
    resources :comments, only: [:create]
  end
  resource :session
  resources :goals, except: [:new, :create] do
    resources :goal_comments, only: [:create]
  end
end
