# frozen_string_literal: true

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
