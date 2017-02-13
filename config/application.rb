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

  end
end
