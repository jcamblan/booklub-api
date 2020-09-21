# frozen_string_literal: true

Fabricator(:submission) do
  book
  user
  session
end
