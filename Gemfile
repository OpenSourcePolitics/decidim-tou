# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = "0.28"
DECIDIM_BRANCH = "develop"

ruby RUBY_VERSION

# Many gems depend on environment variables, so we load them as soon as possible
gem "dotenv-rails", require: "dotenv/rails-now"

# Core gems
gem "decidim", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_BRANCH
gem "decidim-conferences", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_BRANCH

# External Decidim gems
# gem "decidim-cache_cleaner"
# gem "decidim-cleaner"
# gem "decidim-decidim_awesome"
# gem "decidim-faceless", git: "https://github.com/digidemlab/decidim-module-faceless", branch: DECIDIM_BRANCH
# gem "decidim-friendly_signup", git: "https://github.com/OpenSourcePolitics/decidim-module-friendly_signup.git"
# gem "decidim-homepage_interactive_map", git: "https://github.com/OpenSourcePolitics/decidim-module-homepage_interactive_map.git", branch: DECIDIM_BRANCH
# gem "decidim-phone_authorization_handler", git: "https://github.com/OpenSourcePolitics/decidim-module_phone_authorization_handler", branch: "0.26/without-exports"
# gem "decidim-spam_detection"
# gem "decidim-term_customizer", git: "https://github.com/armandfardeau/decidim-module-term_customizer.git", branch: "fix/precompile-on-docker-0.26"

# Default
# gem "activejob-uniqueness", require: "active_job/uniqueness/sidekiq_patch"
# gem "aws-sdk-s3", require: false
gem "bootsnap", "~> 1.4"
gem "puma", ">= 6.3.1"
# gem "faker", "~> 3.2"
# gem "fog-aws"
# gem "foundation_rails_helper", git: "https://github.com/sgruhier/foundation_rails_helper.git"
# gem "rack-attack", "~> 6.6"
# gem "sys-filesystem"

group :development do
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 4.2"
  gem "listen", "~> 3.1"
end

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "decidim-dev", git: "https://github.com/decidim/decidim.git", branch: DECIDIM_BRANCH
  gem "brakeman", "~> 5.4"
  gem "net-imap", "~> 0.2.3"
  gem "net-pop", "~> 0.1.1"
  gem "net-smtp", "~> 0.3.1"
  gem "parallel_tests", "~> 4.2"
  gem "bullet"
  gem "flamegraph"
  gem "memory_profiler"
  gem "rack-mini-profiler", require: false
  gem "stackprof"
end

group :production do
  # gem "dalli"
  # gem "health_check", "~> 3.1"
  # gem "lograge"
  # gem "sendgrid-ruby"
  # gem "sentry-rails"
  gem "sentry-ruby"
  # gem "sentry-sidekiq"
  gem "sidekiq", "~> 6.0"
  gem "sidekiq_alive", "~> 2.2"
  gem "sidekiq-scheduler", "~> 5.0"
end
