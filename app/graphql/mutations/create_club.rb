# frozen_string_literal: true

module Mutations
  class CreateClub < BaseMutation
    field :club, Types::ClubType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :name, String, required: true
    argument :file, ApolloUploadServer::Upload, required: false

    def resolve(**args)
      authorize! Club, to: :create?

      with_validation! do
        args[:manager] = current_user
        args[:banner] = blobify(args.delete(:file)) if args[:file]

        club = Club.create!(args)

        { club: club, errors: [] }
      end
    end

    def blobify(file)
      ActiveStorage::Blob.create_and_upload!(
        io: file,
        filename: file.original_filename,
        content_type: file.content_type
      )
    end
  end
end
