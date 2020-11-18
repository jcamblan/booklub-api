# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseModelType
    global_id_field :id
    field :name, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :books, BookType.connection_type, null: true
  end
end
