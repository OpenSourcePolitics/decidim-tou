# frozen_string_literal: true

require_relative "boot"

require "decidim/rails"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module DevelopmentApp
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.yml").to_s]

    # This needs to be set for correct images URLs in emails
    # DON'T FORGET to ALSO set this in `config/initializers/carrierwave.rb`
    config.action_mailer.asset_host = "https://#{Rails.application.secrets[:asset_host]}/" if Rails.application.secrets[:asset_host].present?

    config.backup = config_for(:backup).deep_symbolize_keys

    config.action_dispatch.default_headers = {
      "X-Frame-Options" => "SAMEORIGIN",
      "X-XSS-Protection" => "1; mode=block",
      "X-Content-Type-Options" => "nosniff"
    }
  end
end
