# frozen_string_literal: true

Fabricator(:token, class_name: 'Doorkeeper::AccessToken') do
  transient :user
  application
  resource_owner_id { |attrs| attrs[:user] ? attrs[:user].id : Fabricate(:user).id }
end
