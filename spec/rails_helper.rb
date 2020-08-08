# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_group 'GQL Types', 'app/graphql/types'
  add_group 'GQL Resolvers', 'app/graphql/resolvers'
  add_group 'GQL Mutations', 'app/graphql/mutations'
  add_group 'Models', 'app/models'
  add_group 'Jobs', 'app/jobs'
  add_group 'Services', 'app/services'
  add_group 'Policies', 'app/policies'
  add_group 'Controllers', 'app/controllers'
end

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') unless Rails.env.test?
require 'rspec/rails'
require 'sidekiq/testing'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
Dir[Rails.root.join('spec/configs/**/*.rb')].sort.each { |f| require f }

# Activate Sidekiq test mode
Sidekiq::Testing.fake!

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include Requests::GraphqlHelpers, type: :request

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.global_fixtures = :all

  # Clear all workers' jobs
  Sidekiq::Worker.clear_all
end
