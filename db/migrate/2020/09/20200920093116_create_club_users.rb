# frozen_string_literal: true

class CreateClubUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :club_users, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :club_id, null: false
      t.bigint :score, null: false, default: 1

      t.timestamps
    end

    safety_assured do
      add_foreign_key :club_users, :users, column: :user_id
      add_foreign_key :club_users, :clubs, column: :club_id
    end

    add_index :club_users, %i[user_id club_id], unique: true
    add_index :club_users, :club_id
    add_index :club_users, :user_id
  end
end
