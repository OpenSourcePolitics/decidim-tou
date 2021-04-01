# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", git: "https://github.com/OpenSourcePolitics/decidim.git", branch: "alt/toulouse"
gem "decidim-conferences", git: "https://github.com/OpenSourcePolitics/decidim.git", branch: "alt/toulouse"

# Modules
gem "decidim-homepage_interactive_map", git: "https://github.com/OpenSourcePolitics/decidim-module-homepage_interactive_map.git", branch: "release/0.18-stable"

gem "bootsnap", "~> 1.3"
gem "puma", "~> 3.0"
gem "uglifier", "~> 4.1"

gem "faker", "~> 1.8"

gem "ruby-progressbar"
gem "sentry-raven"

gem "letter_opener_web", "~> 1.3"
gem "omniauth-oauth2", ">= 1.4.0", "< 2.0"
gem "sprockets", "~> 3.7"

group :development, :test do
  gem "byebug", "~> 10.0", platform: :mri
  gem "decidim-dev", git: "https://github.com/OpenSourcePolitics/decidim.git", branch: "alt/toulouse"
  gem "dotenv-rails"

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
