# frozen_string_literal: true

class SessionDrawJob < ApplicationJob
  queue_as :default

  def perform(session)
    elected_book_id = draw_book_from(session)
    session.update(selected_book_id: elected_book_id)
    refresh_users_scores_from(session)
  end

  private

  def draw_book_from(session)
    pool = []

    # user score increase his books chances to be selected
    session.submissions.each do |submission|
      score = ClubUser.find_by(club: session.club, user: submission.user).score
      score.times do
        pool << submission.book_id
      end
    end

    pool.sample
  end

  def refresh_users_scores_from(session)
    ClubUser.joins(user: :submissions)
            .where(submissions: { session: session })
            .find_each(&:refresh_stats)
  end
end
