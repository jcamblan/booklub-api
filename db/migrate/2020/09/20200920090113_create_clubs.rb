# frozen_string_literal: true

class CreateClubs < ActiveRecord::Migration[6.0]
  def change
    create_table :clubs, id: :uuid do |t|
      t.uuid :manager_id
      t.string :name

      t.timestamps
    end

    safety_assured { add_foreign_key :clubs, :users, column: :manager_id }
    add_index :clubs, :name
  end
end
