Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.application.config.allowed_cors_origins
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end

# If you want to guard against header attacks on production, you have to manually permit the allowed hosts:
Rails.application.config.hosts << 'therealrodk.dev'
Rails.application.config.hosts << 'hatchboxapp.com'
