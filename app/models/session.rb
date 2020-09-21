# frozen_string_literal: true

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
