# if Rails.env == 'production' 
#   Rails.application.config.session_store :cookie_store, key: '_lets-kari-to-the-next', domain: 'https://lets-meetup-app.herokuapp.com'
# else
  Rails.application.config.session_store :cookie_store, key: '_lets-kari-to-the-next', same_site: :none, secure: Rails.env.production? || Rails.env.development?
# end

