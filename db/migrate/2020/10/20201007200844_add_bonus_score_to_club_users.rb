# frozen_string_literal: true

class AddBonusScoreToClubUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_column :club_users, :bonus_score, :integer, null: false, default: 0
    safety_assured { remove_column :club_users, :score }
  end

  def self.down
    remove_column :club_users, :bonus_score
    add_column :club_users, :score, :integer, null: false, default: 0
  end
end
