# frozen_string_literal: true

return unless defined?(Decidim::ExtraUserFields)

Decidim::ExtraUserFields.configure do |config|
  config.notifications_sending_frequency = "none"
end
