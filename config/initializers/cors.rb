Rails.application.config.middleware.insert_before 0, Rack::Cors do 
  allow do
    origins 'https://chatti-room.herokuapp.com'
    # 'http://localhost:3000'
    # 'https://lets-meetup-app.herokuapp.com'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head], 
      credentials: true
  end
end

