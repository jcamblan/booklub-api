# frozen_string_literal: true

module Types
  class SessionType < Types::BaseModelType
    # == Order =================================================================

    class Types::SessionOrderBy < ::Types::BaseEnum
      value :submission_due_date
      value :read_due_date
      value :state
      value :created_at
      value :updated_at
    end

    class Types::SessionOrder < ::Types::BaseInputObject
      argument :by, Types::SessionOrderBy, required: true
      argument :direction, Types::OrderDirection, required: true
    end

    # == Fields ================================================================

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
    field :submissions, Connections::SubmissionsConnection, null: true
    field :notes, Types::NoteType.connection_type, null: true
    field :user_note, Types::NoteType, null: true
    field :participates, Boolean, null: false

    expose_authorization_rules :participate?, :note?

    def user_note
      object.notes.find_by(user: current_user)
    end

    def participates
      object.users.include?(current_user)
    end
  end
end
