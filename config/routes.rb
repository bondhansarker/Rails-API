Rails.application.routes.draw do
  resources :blogs
  resources :users
  post '/authenticate', to: 'authentication#authenticate'
  delete '/sign_out', to: 'authentication#sign_out'
end
