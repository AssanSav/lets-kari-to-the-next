# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
run Rails.application

use Rack::Cors do
   allow do
    origins 'https://lets-meetup-app.herokuapp.com'
    # 'http://localhost:3000'
    # 'https://lets-meetup-app.herokuapp.com'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head], 
      credentials: true
  # allow do
  #   origins 'https://lets-meetup-app.herokuapp.com'
  #   resource '*',
  #   :headers => :any,
  #   :methods => [:get, :post, :delete, :put, :patch, :options],
  #   credentials: true
  end
end


