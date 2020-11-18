# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors, id: :uuid do |t|
      t.string :name
      t.timestamps
    end
  end
end
