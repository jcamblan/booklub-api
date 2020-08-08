# frozen_string_literal: true

Fabricator(:application, class_name: 'Doorkeeper::Application') do
  name { 'react-app' }
  secret { SecureRandom.uuid }
end
