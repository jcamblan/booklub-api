# frozen_string_literal: true

module Mutations
  class JoinClub < BaseMutation
    field :club, Types::ClubType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :invitation_code, String, required: true

    def resolve(invitation_code:)
      with_validation! do
        club = Club.find_by!(invitation_code: invitation_code)
        authorize! club, to: :join?

        current_user.clubs << club
        { club: club, errors: [] }
      end
    end
  end
end
