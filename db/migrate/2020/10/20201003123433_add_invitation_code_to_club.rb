# frozen_string_literal: true

class AddInvitationCodeToClub < ActiveRecord::Migration[6.0]
  def change
    add_column :clubs, :invitation_code, :string, null: false
    safety_assured { add_index :clubs, :invitation_code, unique: true }
  end
end
