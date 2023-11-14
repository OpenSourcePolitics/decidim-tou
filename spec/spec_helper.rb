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
