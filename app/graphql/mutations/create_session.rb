# frozen_string_literal: true

module Mutations
  class CreateSession < BaseMutation
    field :session, Types::SessionType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :club_id, ID, required: true, loads: Types::ClubType
    argument :submission_due_date, GraphQL::Types::ISO8601DateTime, required: true
    argument :read_due_date, GraphQL::Types::ISO8601DateTime, required: true
    argument :name, String, required: false

    def resolve(**args)
      session = Session.new(args)
      authorize! session, to: :create?

      with_validation! do
        session.save!
        { session: session, errors: [] }
      end
    end
  end
end
