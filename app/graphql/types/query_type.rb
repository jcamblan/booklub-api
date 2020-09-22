# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :my_clubs, resolver: Resolvers::MyClubs
  end
end
