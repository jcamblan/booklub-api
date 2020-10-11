class AddStatsToBooks < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    safety_assured do
      change_table :books do |t|
        t.integer :submission_count, null: false, default: 0
        t.integer :selection_count, null: false, default: 0
        t.integer :note_count, null: false, default: 0
        t.float :average_note, null: true
      end
    end

    add_index :books, :submission_count, algorithm: :concurrently
    add_index :books, :selection_count, algorithm: :concurrently
    add_index :books, :average_note, algorithm: :concurrently
  end
end
