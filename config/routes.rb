Rails.application.routes.draw do
  
  namespace :api do 
    namespace :v1 do 
      # resources :profiles
      resources :users
      resources :interests
    end
  end

  get "api/v1/session/status", to: "api/v1/sessions#is_logged_in?"
  delete "api/v1/logout/:id", to: "api/v1/sessions#destroy"
  post "api/v1/login", to: "api/v1/sessions#login"
  get "api/v1/matches", to: "api/v1/users#my_matches"
end
