# frozen_string_literal: true

# == Schema Information
#
# Table name: submissions
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :uuid             not null
#  session_id :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_submissions_on_book_id                 (book_id)
#  index_submissions_on_session_id              (session_id)
#  index_submissions_on_user_id                 (user_id)
#  index_submissions_on_user_id_and_session_id  (user_id,session_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (session_id => sessions.id)
#  fk_rails_...  (user_id => users.id)
#
class Submission < ApplicationRecord
  # == Constants ===============================================================
  # == Attributes ==============================================================
  # == Extensions ==============================================================
  # == Relationships ===========================================================

  belongs_to :session
  belongs_to :user
  belongs_to :book

  accepts_nested_attributes_for :book

  # == Validations =============================================================

  validates :user_id, uniqueness: { scope: :session_id }
  validates :book_id, presence: true

  # == Scopes ==================================================================
  # == Callbacks ===============================================================

  counter_culture :book, column_name: 'submission_count'

  # == Class Methods ===========================================================
  # == Instance Methods ========================================================
end
