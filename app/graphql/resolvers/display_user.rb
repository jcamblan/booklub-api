# frozen_string_literal: true

module Resolvers
  class DisplayUser < BaseResolver
    type Types::UserType, null: true

    argument :user_id, ID, required: true, loads: Types::UserType

    def resolve(**args)
      args[:user]
    end
  end
end
