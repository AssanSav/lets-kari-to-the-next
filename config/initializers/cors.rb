Rails.application.config.middleware.insert_before 0, Rack::Cors do 
  allow do
    origins "https://lets-carry-on.herokuapp.com"
    
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
    credentials: true
  end
end

# "https://lets-carry-on.herokuapp.com/"
# ENV['FRONT_END_URL']
# 'http://localhost:3000'
# "https://lets-meetup.netlify.app"
# 