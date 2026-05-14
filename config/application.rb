require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Bulktrack
  class Application < Rails::Application
    config.load_defaults 8.0 # or your current active rails version

    # ✅ Add this directly inside the Application class block
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:5173', 'http://127.0.0.1:5173'
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          expose: ['Authorization']
      end
    end

  end
end
