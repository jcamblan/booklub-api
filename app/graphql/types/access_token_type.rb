# frozen_string_literal: true

module Types
  class AccessTokenType < Types::BaseModelType
    field :token, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
