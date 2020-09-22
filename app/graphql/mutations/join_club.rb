# frozen_string_literal: true

module Mutations
  class JoinClub < BaseMutation
    field :user, Types::UserType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :club_id, ID, required: true, loads: Types::ClubType

    def resolve(club:)
      with_validation! do
        current_user.clubs << club
        { user: current_user, errors: [] }
      end
    end
  end
end
