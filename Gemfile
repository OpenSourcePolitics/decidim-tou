# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", "0.23.6"
gem "decidim-conferences", "0.23.6"

# Modules
gem "decidim-decidim_awesome", "~> 0.6.6"
gem "decidim-homepage_interactive_map", git: "https://github.com/OpenSourcePolitics/decidim-module-homepage_interactive_map.git", branch: "release/0.23-stable"
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer", branch: "0.23-stable"

gem "bootsnap", "~> 1.4"
gem "decidim-user_exporter", git: "https://github.com/OpenSourcePolitics/decidim-module-user_exporter.git", branch: "main"
gem "puma", ">= 5.3.1"
gem "uglifier", "~> 4.1"

gem "dotenv-rails"

gem "faker", "~> 1.9"

gem "ruby-progressbar"
gem "sentry-raven"

gem "letter_opener_web", "~> 1.3"
gem "omniauth-oauth2", ">= 1.4.0", "< 2.0"
gem "sprockets", "~> 3.7"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "decidim-dev", "0.23.6"

  # Since the v0.21.0, rubocop-rails is loaded in decidim-dev engine. For the v0.18.0, we can load rubocop-rails directly in app.
  gem "rubocop-rails", require: false
end

group :development do
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end

group :production do
  gem "dalli"
  gem "fog-aws"
  gem "lograge"
  gem "newrelic_rpm"
  gem "passenger"
  gem "sendgrid-ruby"
  gem "sidekiq"
  gem "sidekiq-scheduler"
end
