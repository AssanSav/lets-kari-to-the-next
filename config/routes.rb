Rails.application.routes.draw do
  
  namespace :api do 
    namespace :v1 do 
      resources :users
      resources :interests
      resources :avatars
      resources :messages

      resources :messages do 
        member do 
          patch :update_send_message
          put :update_received_message
        end
      end
    end
  end


  resources :users

  get "api/v1/session/status", to: "api/v1/sessions#is_logged_in?"
  delete "api/v1/logout/:id", to: "api/v1/sessions#destroy"
  post "api/v1/login", to: "api/v1/sessions#login"
  get "api/v1/matches", to: "api/v1/users#my_matches"
  get "api/v1/messages-outbox", to: "api/v1/messages#outbox"
  get "api/v1/messages-inbox", to: "api/v1/messages#inbox"
  # put "api/v1/delete_sent_message", to: "api/v1/messages#delete_sent_message"
end
