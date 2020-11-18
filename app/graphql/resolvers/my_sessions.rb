# frozen_string_literal: true

module Resolvers
  class MySessions < BaseResolver
    type Types::SessionType.connection_type, null: true

    argument :order, Types::SessionOrder, required: false

    def resolve(**args)
      authorize! Session, to: :list_mine?
      connection_with_arguments(current_user.sessions, args)
    end
  end
end
