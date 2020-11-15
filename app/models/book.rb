# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id               :uuid             not null, primary key
#  average_note     :float            default(0.0), not null
#  note_count       :integer          default(0), not null
#  selection_count  :integer          default(0), not null
#  submission_count :integer          default(0), not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  google_book_id   :string
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
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books

  # == Validations =============================================================

  validates :title, presence: true

  # == Scopes ==================================================================

  scope :search, lambda { |search|
                   joins(:authors).where(
                     'books.title ILIKE ?
                     OR books.author ILIKE ?
                     OR authors.name ILIKE ?',
                     "%#{search}%",
                     "%#{search}%",
                     "%#{search}%"
                   )
                 }

  # == Callbacks ===============================================================
  # == Class Methods ===========================================================
  # == Instance Methods ========================================================
end
