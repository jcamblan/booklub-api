# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books, id: :uuid do |t|
      t.string :title, null: false
      t.string :author, null: false

      t.timestamps
    end

    add_column :sessions, :selected_book_id, :uuid, null: true
    safety_assured { add_foreign_key :sessions, :books, column: :selected_book_id }
  end
end
