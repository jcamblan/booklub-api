# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'action_policy-graphql', '~> 0.3' # https://github.com/palkan/action_policy-graphql
gem 'bootsnap', '>= 1.4.2', require: false # https://github.com/Shopify/bootsnap
gem 'clearance', '~> 2.1' # https://github.com/thoughtbot/clearance/
gem 'doorkeeper', '~> 5.4' # https://github.com/doorkeeper-gem/doorkeeper
gem 'graphql', '~> 1.10' # https://github.com/rmosolgo/graphql-ruby
gem 'mutations', '~> 0.9' # https://github.com/cypriss/mutations
gem 'pg', '>= 0.18', '< 2.0' # https://github.com/ged/ruby-pg
gem 'puma', '~> 4.1' # https://github.com/ankane/lockbox
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'simplecov', '~> 0.18.5' # https://github.com/colszowka/simplecov
gem 'strong_migrations', '~> 0.6' # https://github.com/ankane/strong_migrations

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'brakeman' # https://github.com/presidentbeef/brakeman
  gem 'bundler-audit' # https://github.com/rubysec/bundler-audit
  gem 'fabrication', '~> 2.21', '>= 2.21.1' # https://github.com/paulelliott/fabrication
  gem 'faker', '~> 2.13' # https://github.com/faker-ruby/faker
  gem 'pry-byebug' # https://github.com/deivid-rodriguez/pry-byebug
  gem 'pry-clipboard' # https://github.com/hotchpotch/pry-clipboard
  gem 'pry-rails' # https://github.com/rweng/pry-rails
  gem 'rspec-rails' # https://github.com/rspec/rspec-rails
  gem 'rubocop' # https://github.com/rubocop-hq/rubocop
  gem 'rubocop-rails' # https://github.com/rubocop-hq/rubocop-rails
  gem 'rubocop-rspec' # https://github.com/rubocop-hq/rubocop-rspec
end

group :development do
  gem 'annotate' # https://github.com/ctran/annotate_models
  gem 'lefthook', '~> 0.7.2' # https://github.com/Arkweid/lefthook
  gem 'listen', '~> 3.2' # https://github.com/guard/listen
  gem 'spring' # https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0' # https://github.com/jonleighton/spring-watcher-listen
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
