# frozen_string_literal: true

module Mutations
  class Register < BaseMutation
    field :success, Boolean, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :username, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    def resolve(**args)
      with_validation! do
        User.create!(args)
        { success: true, errors: [] }
      end
    end
  end
end
