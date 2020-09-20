# frozen_string_literal: true

class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions, id: :uuid do |t|
      t.uuid :club_id, null: false
      t.string :state, null: false, default: :submission
      t.string :name
      t.datetime :submission_due_date, null: false
      t.datetime :read_due_date, null: false
      t.timestamps
    end

    safety_assured { add_foreign_key :sessions, :clubs, column: :club_id }
    add_index :sessions, :club_id
  end
end
