# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    add_field(GraphQL::Types::Relay::NodeField)

    field :my_clubs, resolver: Resolvers::MyClubs
    field :books, resolver: Resolvers::Books
    field :me, UserType, null: true

    def me
      current_user
    end
  end
end
