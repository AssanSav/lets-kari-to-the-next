

if Rails.env === 'production' 
  Rails.application.config.session_store :cookie_store, key: '_lets-kari-to-the-next', domain: 'https://lets-kari-to-the-next.herokuapp.com'
else
  Rails.application.config.session_store :cookie_store, key: '_lets-kari-to-the-next' 
end

