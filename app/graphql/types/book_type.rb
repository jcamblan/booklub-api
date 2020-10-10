# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    global_id_field :id
    field :title, String, null: false
    field :author, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
