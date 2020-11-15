# frozen_string_literal: true

module Mutations
  class CreateSubmission < BaseMutation
    field :submission, Types::SubmissionType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    class Types::BookAttributes < Types::BaseInputObject
      argument :title, String, required: true
      argument :authors, [String], required: true
      argument :google_book_id, String, required: true
    end

    argument :session_id, ID, required: true, loads: Types::SessionType
    argument :book_attributes, Types::BookAttributes, required: true

    def resolve(session:, book_attributes:) # rubocop:disable Metrics/MethodLength
      authorize! session, to: :participate?

      with_validation! do
        book = Book.find_or_initialize_by(google_book_id: book_attributes[:google_book_id])
        book.assign_attributes(
          title: book_attributes[:title],
          authors: book_attributes[:authors].map do |name|
            Author.find_or_initialize_by(name: name)
          end
        )

        submission = session.submissions.new(user: current_user)

        submission.book = book
        submission.save!

        { submission: submission, errors: [] }
      end
    end
  end
end
