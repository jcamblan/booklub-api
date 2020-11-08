# frozen_string_literal: true

module Mutations
  class ConcludeSession < Mutations::BaseMutation
    field :session, Types::SessionType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :session_id, ID, required: true, loads: Types::SessionType

    def resolve(session:)
      authorize! session, to: :conclude?

      with_validation! do
        session.conclude!
        { session: session, errors: [] }
      end
    end
  end
end
