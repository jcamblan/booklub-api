# frozen_string_literal: true

# == Schema Information
#
# Table name: author_books
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :uuid
#  book_id    :uuid
#
# Foreign Keys
#
#  fk_rails_...  (author_id => authors.id)
#  fk_rails_...  (book_id => books.id)
#
class AuthorBook < ApplicationRecord
  # == Constants ===============================================================
  # == Attributes ==============================================================
  # == Extensions ==============================================================
  # == Relationships ===========================================================

  belongs_to :book
  belongs_to :author

  # == Validations =============================================================
  # == Scopes ==================================================================
  # == Callbacks ===============================================================
  # == Class Methods ===========================================================
  # == Instance Methods ========================================================
end
