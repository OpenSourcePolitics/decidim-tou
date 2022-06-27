# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = "release/0.25-stable"

gem "decidim", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_VERSION
gem "decidim-conferences", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_VERSION

# Modules
# gem "decidim-decidim_awesome", "~> 0.6.6"
# gem "decidim-homepage_interactive_map", git: "https://github.com/OpenSourcePolitics/decidim-module-homepage_interactive_map.git", branch: "bump/0.25-stable"
# gem "decidim-phone_authorization_handler", git: "https://github.com/OpenSourcePolitics/decidim-module_phone_authorization_handler", branch: "bump/0.25-stable"
# gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer", branch: DECIDIM_VERSION

gem "bootsnap", "~> 1.4"
# gem "decidim-user_exporter", git: "https://github.com/OpenSourcePolitics/decidim-module-user_exporter.git", branch: "main"
gem "puma", ">= 5.3.1"
gem "uglifier", "~> 4.1"

gem "dotenv-rails"

gem "faker", "~> 2.14"

gem "ruby-progressbar"
gem "sentry-raven"

gem "letter_opener_web", "~> 1.3"
gem "omniauth-oauth2", ">= 1.4.0", "< 2.0"
gem "sprockets", "~> 3.7"
gem "decidim-faceless", git: "https://github.com/digidemlab/decidim-module-faceless", branch: "release/0.25-stable"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "decidim-dev", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_VERSION

  # Since the v0.21.0, rubocop-rails is loaded in decidim-dev engine. For the v0.18.0, we can load rubocop-rails directly in app.
  gem "rubocop-rails", require: false
end

group :development do
  gem "listen", "~> 3.1"
  gem "rubocop-faker"
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
