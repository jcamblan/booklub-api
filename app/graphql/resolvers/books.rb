# frozen_string_literal: true

module Resolvers
  class Books < BaseResolver
    type Types::BookType.connection_type, null: true

    argument :order, Types::BookOrder, required: false
    argument :search, String, required: false

    def resolve(**args)
      authorize! Book, to: :index?
      connection_with_arguments(Book.all, args)
    end
  end
end
