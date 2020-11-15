# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    # == Order =================================================================

    class Types::BookOrderBy < ::Types::BaseEnum
      value :title
      value :average_note
      value :submission_count
      value :note_count
      value :created_at
    end

    class Types::BookOrder < ::Types::BaseInputObject
      argument :by, Types::BookOrderBy, required: true
      argument :direction, Types::OrderDirection, required: true
    end

    # == Fields ================================================================

    global_id_field :id
    field :title, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :submission_count, Integer, null: false
    field :note_count, Integer, null: false
    field :average_note, Float, null: true
    field :google_book_id, String, null: true

    field :authors, AuthorType.connection_type, null: false
  end
end
