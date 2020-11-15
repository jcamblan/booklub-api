# frozen_string_literal: true

module Types
  class UserType < Types::BaseModelType
    global_id_field :id
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :username, String, null: true
    field :email, String, null: true, authorize_field: true
  end
end
