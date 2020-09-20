# frozen_string_literal: true

Fabricator(:club_user) do
  club
  user
  score { 0 }
end
