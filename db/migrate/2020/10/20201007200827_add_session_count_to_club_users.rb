# frozen_string_literal: true

class AddSessionCountToClubUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_column :club_users, :session_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :club_users, :session_count
  end
end
