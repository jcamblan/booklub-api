# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    add_field(GraphQL::Types::Relay::NodeField)

    field :my_clubs, resolver: Resolvers::MyClubs
  end
end
