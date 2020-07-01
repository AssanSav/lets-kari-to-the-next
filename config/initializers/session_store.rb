

if Rails.env == 'production' 
  binding.pry
  Rails.application.config.session_store :cookie_store, key: '_lets-kari-to-the-next', domain: '*.herokuapp.com'
else
  Rails.application.config.session_store :cookie_store, key: '_lets-kari-to-the-next' 
end

