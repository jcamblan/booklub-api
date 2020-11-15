# frozen_string_literal: true

module Resolvers
  class Me < BaseResolver
    type Types::UserType, null: true

    def resolve
      authorize! current_user || User.new, to: :me?
      current_user
    end
  end
end
