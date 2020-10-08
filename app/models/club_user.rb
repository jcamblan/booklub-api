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
class ClubUser < ApplicationRecord
  # == Constants ===============================================================
  # == Attributes ==============================================================
  # == Extensions ==============================================================
  # == Relationships ===========================================================

  belongs_to :user
  belongs_to :club

  # == Validations =============================================================

  validates :club_id, uniqueness: { scope: :user_id }

  # == Scopes ==================================================================
  # == Callbacks ===============================================================
  # == Class Methods ===========================================================
  # == Instance Methods ========================================================

  def submissions
    user.submissions.join(:session).where(sessions: { club: club })
  end

  # bonus_score is a bad luck protection
  # each non selected user submission in a club session grant him 1 point
  # score drop to 0 when the user submission is selected in a draw
  def calculate_score
    score = 0

    submissions.where(
      sessions: { state: %w[reading conclusion archived] }
    ).find_each do |submission|
      score += 1
      next unless submission.book_id == submission.session.selected_book_id

      score = 0
    end

    score
  end

  # how many sessions did the user participated in?
  def calculate_session_count
    user.submissions.join(:session).where(sessions: { club: club }).count
  end

  # how many times did the user submissions were selected?
  def calculate_selection_count
    submissions.select { |sub| sub.book_id == sub.session.selected_book_id }.count
  end

  def refresh_stats
    update(
      bonus_score: calculate_score,
      selection_count: calculate_selection_count,
      session_count: calculate_session_count
    )
  end
end
