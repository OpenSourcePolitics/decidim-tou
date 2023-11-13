# frozen_string_literal: true

return unless defined?(Sentry::Ruby)
require "decidim_app/sentry_setup"

SentrySetup.init
