# frozen_string_literal: true

# == Schema Information
#
# Table name: club_users
#
#  id         :uuid             not null, primary key
#  score      :bigint           default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  club_id    :uuid             not null
#  user_id    :uuid             not null
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
class ClubUser < ApplicationRecord
  # == Constants ===============================================================
  # == Attributes ==============================================================
  # == Extensions ==============================================================
  # == Relationships ===========================================================

  belongs_to :user
  belongs_to :club

  # == Validations =============================================================
  # == Scopes ==================================================================
  # == Callbacks ===============================================================
  # == Class Methods ===========================================================
  # == Instance Methods ========================================================

  def refresh_score
    score = 0

    user.submissions.join(:session).where(
      sessions: { club: club, state: %w[reading conclusion archived] }
    ).find_each do |submission|
      score += 1
      next unless submission.book_id == submission.session.selected_book_id

      score = 0
    end

    update(score: score)
  end
end
