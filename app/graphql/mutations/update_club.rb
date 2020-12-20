# frozen_string_literal: true

module Mutations
  class UpdateClub < BaseMutation
    field :club, Types::ClubType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :club_id, ID, required: true, loads: Types::ClubType
    argument :name, String, required: false
    argument :file, ApolloUploadServer::Upload, required: false

    def resolve(club:, **args)
      authorize! club, to: :update?

      with_validation! do
        args[:banner] = blobify(args.delete(:file)) if args[:file]

        club.update!(args)

        { club: club, errors: [] }
      end
    end
  end
end
