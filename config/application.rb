# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BooklubApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    # I18n locales
    Rails.application.routes.default_url_options[:host] = ENV['BASE_DOMAIN']
    config.i18n.load_path += Dir[
      Rails.root.join('config/locales/**/*.{rb,yml}')
    ]
    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths += Dir[Rails.root.join('lib').to_s,
                                 Rails.root.join('app/models/concerns').to_s]
    I18n.enforce_available_locales = false
    I18n.config.available_locales  = :fr
    config.i18n.default_locale     = :fr
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
