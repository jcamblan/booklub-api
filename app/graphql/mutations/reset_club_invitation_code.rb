# frozen_string_literal: true

module Mutations
  class ResetClubInvitationCode < BaseMutation
    description 'assign a new invitationCode to the club'

    field :club, Types::ClubType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :club_id, ID, required: true, loads: Types::ClubType

    def resolve(club:)
      authorize! club, to: :reset_invitation_code?

      with_validation! do
        club.generate_invitation_code
        club.save!

        { club: club, errors: [] }
      end
    end
  end
end
