# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  id                  :uuid             not null, primary key
#  name                :string
#  next_step_date      :datetime
#  read_due_date       :datetime         not null
#  state               :string           default("submission"), not null
#  submission_due_date :datetime         not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  club_id             :uuid             not null
#  selected_book_id    :uuid
#
# Indexes
#
#  index_sessions_on_club_id  (club_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#  fk_rails_...  (selected_book_id => books.id)
#
Fabricator(:session) do
  name { Faker::Lorem.sentence }
  submission_due_date { Time.zone.now + 1.day }
  read_due_date { Time.zone.now + 2.days }
end
