# frozen_string_literal: true

class AddNewColumnToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :next_step_date, :datetime
  end
end
