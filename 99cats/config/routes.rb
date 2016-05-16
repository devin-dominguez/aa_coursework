Rails.application.routes.draw do
  resources :cats do
    get 'rental_requests/new' => 'cat_rental_requests#new',
      as: 'rental_request'
  end
  resources :cat_rental_requests
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  post 'cat_rental_requests/:id/approve/' => 'cat_rental_requests#approve',
    as: 'approve'
  post 'cat_rental_requests/:id/deny/' => 'cat_rental_requests#deny',
    as: 'deny'
end
