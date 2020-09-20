# frozen_string_literal: true

Fabricator(:club) do
  name { Faker::Company.name }
  manager { Fabricate(:user) }
end
