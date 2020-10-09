# frozen_string_literal: true

module Types
  class NoteType < Types::BaseModelType
    global_id_field :id
    field :session, Types::SessionType, null: false
    field :book, Types::BookType, null: false
    field :user, Types::UserType, null: false
    field :value, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
