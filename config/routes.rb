Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
  resources :users
  post '/authenticate', to: 'authentication#authenticate'
  delete '/sign_out', to: 'authentication#sign_out'
end
