source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "bcrypt", "~> 3.1.7"
gem "commonmarker"
gem "image_processing", "~> 1.2"
gem "importmap-rails"
gem "jbuilder"
gem "kamal", require: false
gem "marksmith"
gem "propshaft"
gem "puma", ">= 5.0"
gem "rails", "~> 8.0.1"
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "sqlite3", ">= 2.1"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "thruster", require: false
gem "turbo-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false


group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "hotwire-spark"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
