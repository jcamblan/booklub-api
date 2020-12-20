# frozen_string_literal: true

module Mutations
  class UpdatePersonalData < BaseMutation
    field :user, Types::UserType, null: true
    field :errors, [Types::ValidationErrorType], null: false

    argument :username, String, required: false
    argument :email, String, required: false
    argument :password, String, required: false
    argument :current_password, String, required: false

    def resolve(**args)
      authorize! current_user, to: :update?

      with_validation! do
        current_user.assign_attributes(args)
        current_user.save!
        { user: current_user, errors: [] }
      end
    end
  end
end
