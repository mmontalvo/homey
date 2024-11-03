source "https://rubygems.org"
ruby "3.2.2"

gem "rails", "~> 7.2.2"

gem "sprockets-rails"

gem "pg"

gem "puma", ">= 5.0"

gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

gem "jbuilder"

gem "redis", ">= 4.0.1"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  gem "brakeman", require: false
  gem "reek"
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 7.0.0"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
  gem "pry"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 6.0"
end

gem "devise", "~> 4.9"
gem "faker", "~> 3.5"

gem "rails_event_store"
gem "sidekiq", "<7"
gem "sidekiq-unique-jobs", "~> 7.1"
gem "ruby_event_store-sidekiq_scheduler"
