# frozen_string_literal: true

module Mutations
  class CreateClub < BaseMutation
    field :club, Types::ClubType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :name, String, required: true

    def resolve(name:)
      authorize! Club, to: :create?

      with_validation! do
        club = Club.create!(name: name, manager: current_user)
        { club: club, errors: [] }
      end
    end
  end
end
