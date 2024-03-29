# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = "0.26"
DECIDIM_BRANCH = "release/#{DECIDIM_VERSION}-stable"

ruby RUBY_VERSION

# Many gems depend on environment variables, so we load them as soon as possible
gem "dotenv-rails", require: "dotenv/rails-now"

# Core gems
gem "decidim", "~> #{DECIDIM_VERSION}.0"
gem "decidim-conferences", "~> #{DECIDIM_VERSION}.0"

# External Decidim gems
gem "decidim-cache_cleaner"
gem "decidim-cleaner", git: "https://github.com/OpenSourcePolitics/decidim-module-cleaner.git", branch: "rc/2.1.2"
gem "decidim-decidim_awesome", "~> 0.8.3"
gem "decidim-faceless", git: "https://github.com/digidemlab/decidim-module-faceless", branch: DECIDIM_BRANCH
gem "decidim-friendly_signup", git: "https://github.com/OpenSourcePolitics/decidim-module-friendly_signup.git", branch: "release/0.26-stable"
gem "decidim-homepage_interactive_map", git: "https://github.com/OpenSourcePolitics/decidim-module-homepage_interactive_map.git", branch: DECIDIM_BRANCH
gem "decidim-phone_authorization_handler", git: "https://github.com/OpenSourcePolitics/decidim-module_phone_authorization_handler", branch: "0.26/without-exports"
gem "decidim-spam_detection"
gem "decidim-term_customizer", git: "https://github.com/armandfardeau/decidim-module-term_customizer.git", branch: "fix/precompile-on-docker-0.26"

# Default
gem "activejob-uniqueness", require: "active_job/uniqueness/sidekiq_patch"
gem "aws-sdk-s3", require: false
gem "bootsnap", "~> 1.4"
gem "faker", "~> 2.14"
gem "fog-aws"
gem "foundation_rails_helper", git: "https://github.com/sgruhier/foundation_rails_helper.git"
gem "nokogiri", "1.13.4"
gem "puma", ">= 5.5.1"
gem "rack-attack", "~> 6.6"
gem "sys-filesystem"
gem "wicked_pdf", "~> 2.6.3"

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "rubocop-faker"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "4.0.4"
end

group :development, :test do
  gem "brakeman", "~> 5.1"
  gem "byebug", "~> 11.0", platform: :mri
  gem "climate_control", "~> 1.2"
  gem "decidim-dev", "~> #{DECIDIM_VERSION}.0"
  gem "parallel_tests"
end

group :production do
  gem "dalli"
  gem "health_check", "~> 3.1"
  gem "lograge"
  gem "sendgrid-ruby"
  gem "sentry-rails"
  gem "sentry-ruby"
  gem "sentry-sidekiq"
  gem "sidekiq", "~> 6.0"
  gem "sidekiq_alive", "~> 2.2"
  gem "sidekiq-scheduler", "~> 5.0"
end
