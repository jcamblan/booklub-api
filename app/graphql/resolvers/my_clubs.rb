# frozen_string_literal: true

module Resolvers
  class MyClubs < BaseResolver
    type Types::ClubType.connection_type, null: true

    def resolve
      authorize! Club, to: :list_mine?
      current_user.clubs
    end
  end
end
