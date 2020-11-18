# frozen_string_literal: true

class UpdateBookAttributes < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      change_table :books, bulk: true do |t|
        t.uuid :author_id
        t.string :google_book_id
      end

      add_foreign_key :books, :authors, column: :author_id
    end

    Book.find_each do |book|
      author = Author.find_or_create_by(name: book.author)
      book.update(author_id: author.id)
    end
  end
end
