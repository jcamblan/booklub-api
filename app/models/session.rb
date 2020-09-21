# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  id                  :uuid             not null, primary key
#  name                :string
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
class Session < ApplicationRecord
  # == Constants ===============================================================
  # == Attributes ==============================================================
  # == Extensions ==============================================================

  include AASM

  # == Relationships ===========================================================

  belongs_to :club
  has_many :submissions, dependent: :destroy

  # == Validations =============================================================

  validates :submission_due_date, presence: true
  validates :read_due_date, presence: true

  # == Scopes ==================================================================
  # == Callbacks ===============================================================
  # == State Machine ===========================================================

  aasm column: 'state' do
    state :submission, initial: true, display: I18n.t('models.session.state.submission')
    state :draw, display: I18n.t('models.session.state.draw')
    state :reading, display: I18n.t('models.session.state.reading')
    state :conclusion, display: I18n.t('models.session.state.conclusion')
    state :archived, display: I18n.t('models.session.state.archived')

    event :start_draw do
      after do
        SessionDrawJob.perform_later(self)
      end

      transitions from: :submission, to: :draw
    end

    event :start_reading do
      before do
        # TODO: Send notification
      end

      transitions from: :draw, to: :reading
    end

    event :conclude do
      transitions from: :reading, to: :conclusion
    end

    event :archive do
      transitions from: :conclusion, to: :archived
    end
  end

  # == Class Methods ===========================================================
  # == Instance Methods ========================================================
end