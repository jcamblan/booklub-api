# frozen_string_literal: true

module Mutations
  class CreateSubmission < BaseMutation
    field :submission, Types::SubmissionType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    class Types::BookAttributes < Types::BaseInputObject
      argument :title, String, required: true
      argument :author, String, required: true
    end

    argument :session_id, ID, required: true, loads: Types::SessionType
    argument :book_id, ID, required: false, loads: Types::BookType
    argument :book_attributes, Types::BookAttributes, required: false

    def resolve(session:, book: nil, book_attributes: {})
      authorize! session, to: :participate?

      with_validation! do
        submission = session.submissions.new(user: current_user)

        ActiveRecord::Base.transaction do
          submission.book = book || Book.find_or_create_by(book_attributes.to_h)
          submission.save!
        end

        { submission: submission, errors: [] }
      end
    end
  end
end
