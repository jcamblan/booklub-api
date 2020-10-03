# frozen_string_literal: true

module Types
  class ClubType < Types::BaseObject
    global_id_field :id
    field :name, String, null: true
    field :invitation_code, String, null: true, authorize_field: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
