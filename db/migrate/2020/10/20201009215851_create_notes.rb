# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes, id: :uuid do |t|
      t.uuid :session_id, null: false
      t.uuid :book_id, null: false
      t.uuid :user_id, null: false
      t.integer :value

      t.timestamps
    end

    safety_assured do
      add_foreign_key :notes, :sessions, column: :session_id
      add_foreign_key :notes, :books, column: :book_id
      add_foreign_key :notes, :users, column: :user_id
    end

    add_index :notes, :book_id
    add_index :notes, :session_id
    add_index :notes, :user_id

    add_index :notes, %i[book_id session_id user_id], unique: true
  end
end
