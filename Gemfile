# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'aasm', '~> 5.1', '>= 5.1.1' # https://github.com/aasm/aasm
gem 'action_policy-graphql', '~> 0.3' # https://github.com/palkan/action_policy-graphql
gem 'apollo_upload_server', '2.0.3'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.2', require: false # https://github.com/Shopify/bootsnap
gem 'clearance', '~> 2.1' # https://github.com/thoughtbot/clearance/
gem 'counter_culture', '~> 2.6' # https://github.com/magnusvk/counter_culture
gem 'doorkeeper', '~> 5.4' # https://github.com/doorkeeper-gem/doorkeeper
gem 'dry-effects', '~> 0.1'
gem 'dry-initializer', '~> 3.0'
gem 'dry-rails', '~> 0.1'
gem 'dry-struct', '~> 1.3'
gem 'dry-types', '~> 1.4'
gem 'graphql', '~> 1.10' # https://github.com/rmosolgo/graphql-ruby
gem 'guard-livereload'
gem 'image_processing'
gem 'pg', '>= 0.18', '< 2.0' # https://github.com/ged/ruby-pg
gem 'puma', '~> 4.1'
gem 'rack-cors'
gem 'rack-livereload'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'sidekiq', '~> 6.1'
gem 'simplecov', '~> 0.18.5' # https://github.com/colszowka/simplecov
gem 'stimulus-rails'
gem 'strong_migrations', '~> 0.6' # https://github.com/ankane/strong_migrations
gem 'tailwindcss-rails'
gem 'view_component', '~> 2.46'
gem 'webpacker', '~> 5.4'

group :development, :test do
  gem 'brakeman' # https://github.com/presidentbeef/brakeman
  gem 'bundler-audit' # https://github.com/rubysec/bundler-audit
  gem 'fabrication', '~> 2.21', '>= 2.21.1' # https://github.com/paulelliott/fabrication
  gem 'faker', '~> 2.13' # https://github.com/faker-ruby/faker
  gem 'pry-byebug' # https://github.com/deivid-rodriguez/pry-byebug
  gem 'pry-clipboard' # https://github.com/hotchpotch/pry-clipboard
  gem 'pry-rails' # https://github.com/rweng/pry-rails
  gem 'rspec-rails' # https://github.com/rspec/rspec-rails
end

group :development do
  gem 'annotate' # https://github.com/ctran/annotate_models
  gem 'lefthook', '~> 0.7.2' # https://github.com/Arkweid/lefthook
  gem 'listen', '~> 3.2' # https://github.com/guard/listen
  gem 'rubocop' # https://github.com/rubocop-hq/rubocop
  gem 'rubocop-rails' # https://github.com/rubocop-hq/rubocop-rails
  gem 'rubocop-rspec', '~> 2.0.0.pre' # https://github.com/rubocop-hq/rubocop-rspec
  gem 'spring' # https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0' # https://github.com/jonleighton/spring-watcher-listen
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
