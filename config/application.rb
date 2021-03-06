require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Bundler.require(:default,:assets, Rails.env)
module Systems
  class Application < Rails::Application
    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', {expires_in: 90.minutes}
    config.autoload_paths << Rails.root.join('lib')
    config.serve_static_assets = true
    config.generators do |g|
      g.test_framework :rspec, fixtures:true, views:false
      g.fixture_replacement :factory_girl, dir:"spec/factories"

    end
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
