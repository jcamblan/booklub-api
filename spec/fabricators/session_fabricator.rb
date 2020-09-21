# frozen_string_literal: true

Fabricator(:session) do
  name { Faker::Lorem.sentence }
  submission_due_date { Time.zone.now + 1.day }
  read_due_date { Time.zone.now + 2.days }
end
