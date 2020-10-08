# frozen_string_literal: true

class AddSelectionCountToClubUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_column :club_users, :selection_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :club_users, :selection_count
  end
end
