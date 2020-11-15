# frozen_string_literal: true

module Types
  class CurrentUserType < Types::UserType
    field :email, String, null: true, authorize_field: true
  end
end
