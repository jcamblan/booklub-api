# frozen_string_literal: true

module Mutations
  class NoteSession < BaseMutation
    field :note, Types::NoteType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :session_id, ID, required: true, loads: Types::SessionType
    argument :note_value, Int, required: false, description: Note::VALID_NOTES.to_s

    def resolve(session:, note_value:)
      authorize! session, to: :note?

      with_validation! do
        note = session.notes.find_or_initialize_by(
          user: current_user,
          book: session.selected_book
        )
        note.value = note_value
        note.save!

        { note: note, errors: [] }
      end
    end
  end
end
