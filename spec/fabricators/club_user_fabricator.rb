# frozen_string_literal: true

# == Schema Information
#
# Table name: club_users
#
#  id              :uuid             not null, primary key
#  bonus_score     :integer          default(0), not null
#  selection_count :integer          default(0), not null
#  session_count   :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  club_id         :uuid             not null
#  user_id         :uuid             not null
#
# Indexes
#
#  index_club_users_on_club_id              (club_id)
#  index_club_users_on_user_id              (user_id)
#  index_club_users_on_user_id_and_club_id  (user_id,club_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#  fk_rails_...  (user_id => users.id)
#
Fabricator(:club_user) do
  club
  user
  score { 0 }
end
