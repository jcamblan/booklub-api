# frozen_string_literal: true

class DeleteAuthorOnBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :author_books, id: :uuid do |t|
      t.uuid :book_id
      t.uuid :author_id
      t.timestamps
    end

    safety_assured do
      add_foreign_key :author_books, :books, column: :book_id
      add_foreign_key :author_books, :authors, column: :author_id
    end

    Book.find_each do |book|
      author = Author.find(book.author_id)
      AuthorBook.find_or_create_by(book: book, author: author)
    end

    safety_assured do
      remove_column :books, :author, :string
      remove_column :books, :author_id, :uuid
    end
  end
end
