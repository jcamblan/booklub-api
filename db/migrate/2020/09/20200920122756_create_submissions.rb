# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :session_id, null: false
      t.uuid :book_id, null: false

      t.timestamps
    end

    safety_assured do
      add_foreign_key :submissions, :users, column: :user_id
      add_foreign_key :submissions, :sessions, column: :session_id
      add_foreign_key :submissions, :books, column: :book_id
    end

    add_index :submissions, %i[user_id session_id], unique: true
    add_index :submissions, :session_id
    add_index :submissions, :user_id
    add_index :submissions, :book_id
  end
end
