# ✅ Add this line at the absolute top of the file to eliminate the NameError
require 'rack-cors'

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173', 'http://127.0.0.1:5173'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization'],
      credentials: false
  end
end
