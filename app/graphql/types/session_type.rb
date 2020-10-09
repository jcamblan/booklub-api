# frozen_string_literal: true

module Types
  class SessionType < Types::BaseModelType
    global_id_field :id
    field :club, Types::ClubType, null: false
    field :state, String, null: false
    field :name, String, null: true
    field :submission_due_date, GraphQL::Types::ISO8601DateTime, null: false
    field :read_due_date, GraphQL::Types::ISO8601DateTime, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :selected_book, Types::BookType, null: true
    field :selected_book_submitters, UserType.connection_type, null: true
    field :submissions, Types::Connections::SubmissionsConnection, null: true
    field :notes, Types::NoteType.connection_type, null: true
  end
end
