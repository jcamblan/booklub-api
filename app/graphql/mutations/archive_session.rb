# frozen_string_literal: true

module Mutations
  class ArchiveSession < Mutations::BaseMutation
    field :session, Types::SessionType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :session_id, ID, required: true, loads: Types::SessionType

    def resolve(session:)
      authorize! session, to: :archive?

      with_validation! do
        session.archive!
        { session: session, errors: [] }
      end
    end
  end
end
