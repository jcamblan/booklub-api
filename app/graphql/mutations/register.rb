# frozen_string_literal: true

module Mutations
  class Register < BaseMutation
    field :user, Types::UserType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :username, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    def resolve(**args)
      with_validation! do
        user = User.create!(args)
        context[:current_user] = user
        { user: user, errors: [] }
      end
    end
  end
end
