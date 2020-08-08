# frozen_string_literal: true

Fabricator(:user) do
  email { Faker::Internet.unique.email }
  password { 'password' }
end
