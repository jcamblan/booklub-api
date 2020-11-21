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
class Session < ApplicationRecord
  # == Constants ===============================================================

  STATES = %w[submission draw reading conclusion archived].freeze

  # == Attributes ==============================================================
  # == Extensions ==============================================================

  include AASM

  # == Relationships ===========================================================

  belongs_to :club
  belongs_to :selected_book, optional: true, class_name: 'Book'
  has_many :submissions, dependent: :destroy
  has_many :notes, dependent: :destroy

  has_many :users, through: :submissions, source: :user

  # == Validations =============================================================

  validates :submission_due_date, presence: true
  validates :read_due_date, presence: true
  validate :one_session_at_a_time, on: :create

  # == Scopes ==================================================================

  scope :active, -> { where(state: %w[submission draw reading]) }

  # == Callbacks ===============================================================

  after_create :apply_default_name
  after_create :archive_previous_session
  before_update :set_next_step_date

  # == State Machine ===========================================================

  aasm column: 'state' do # rubocop:disable Metrics/BlockLength
    state :submission, initial: true, display: I18n.t('models.session.state.submission')
    state :draw, display: I18n.t('models.session.state.draw')
    state :reading, display: I18n.t('models.session.state.reading')
    state :conclusion, display: I18n.t('models.session.state.conclusion')
    state :archived, display: I18n.t('models.session.state.archived')

    event :start_draw do
      after do
        if submissions.count.zero?
          destroy!
        else
          SessionDrawJob.perform_later(self)
        end
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

  def active?
    %w[submission draw reading].include?
  end

  def selected_book_submitters
    return if %w[submission draw].include?(state)

    User.joins(:submissions).where(submissions: { session: self, book: selected_book })
  end

  def one_session_at_a_time
    return if club.sessions.active.count.zero?

    errors.add(:state, :one_session_at_a_time, message: 'Il y a déjà une session en cours')
  end

  def apply_default_name
    return if name.present?

    index = club.sessions.order(created_at: :asc).find_index(self)
    update(name: "Session ##{index + 1}")
  end

  def archive_previous_session
    club.sessions.where(state: :conclusion).find_each(&:archive!)
  end

  def state_precedes?(state_comparison)
    STATES.find_index(state) < STATES.find_index(state_comparison.to_s)
  end

  def state_follows?(state_comparison)
    STATES.find_index(state) > STATES.find_index(state_comparison.to_s)
  end

  def set_next_step_date
    self.next_step_date = state_follows?('draw') ? read_due_date : submission_due_date
  end
end
