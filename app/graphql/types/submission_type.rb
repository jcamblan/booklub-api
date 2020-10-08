# frozen_string_literal: true

module Types
  class SubmissionType < Types::BaseObject
    global_id_field :id
    field :user, Types::UserType, null: false
    field :session, Types::SessionType, null: false
    field :book, Types::BookType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
