# frozen_string_literal: true

require "decidim/dev"
Decidim::Dev.dummy_app_path = File.expand_path(Rails.root.to_s)
require "decidim/dev/test/base_spec_helper"
require "decidim/dev/test/w3c_rspec_validators_overrides"

Dir.glob("./spec/support/**/*.rb").sort.each { |f| require f }

RSpec.configure do |config|
  config.formatter = ENV.fetch("RSPEC_FORMAT", "progress").to_sym
  config.include EnvironmentVariablesHelper
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.args << "--explicitly-allowed-ports=#{Capybara.server_port}"
  options.args << "--headless=new"
  options.args << "--no-sandbox"
  options.args << if ENV["BIG_SCREEN_SIZE"].present?
                    "--window-size=1920,3000"
                  else
                    "--window-size=1920,1080"
                  end
  options.args << "--ignore-certificate-errors" if ENV["TEST_SSL"]
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options:
  )
end
