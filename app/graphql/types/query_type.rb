# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :display_user, resolver: Resolvers::DisplayUser
  end
end
