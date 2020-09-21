# frozen_string_literal: true

Fabricator(:book) do
  title { Faker::Book.title }
  author { Faker::Book.author }
end
