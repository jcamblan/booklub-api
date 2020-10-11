# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id               :uuid             not null, primary key
#  author           :string           not null
#  average_note     :float
#  note_count       :integer          default(0), not null
#  selection_count  :integer          default(0), not null
#  submission_count :integer          default(0), not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_books_on_average_note      (average_note)
#  index_books_on_selection_count   (selection_count)
#  index_books_on_submission_count  (submission_count)
#
class Book < ApplicationRecord
  # == Constants ===============================================================
  # == Attributes ==============================================================
  # == Extensions ==============================================================
  # == Relationships ===========================================================

  has_many :notes, dependent: :destroy

  # == Validations =============================================================

  validates :title, presence: true
  validates :author, presence: true

  # == Scopes ==================================================================
  # == Callbacks ===============================================================
  # == Class Methods ===========================================================
  # == Instance Methods ========================================================
end
