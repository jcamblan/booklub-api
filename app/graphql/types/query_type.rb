# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    add_field(GraphQL::Types::Relay::NodeField)

    field :my_clubs, resolver: Resolvers::MyClubs
    field :my_sessions, resolver: Resolvers::MySessions
    field :books, resolver: Resolvers::Books
    field :me, resolver: Resolvers::Me
  end
end
