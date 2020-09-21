# frozen_string_literal: true

module Mutations
  class SignIn < BaseMutation
    field :access_token, Types::AccessTokenType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :email, String, required: true
    argument :password, String, required: true

    def resolve(email:, password:)
      with_validation! do
        user = User.authenticate(email, password)
        access_token = user&.access_tokens&.create!(
          application_id: Doorkeeper::Application.first.id,
          expires_in: 1.day
        )
        { access_token: access_token, errors: [] }
      end
    end
  end
end
