# frozen_string_literal: true

module Types
  class ClubType < Types::BaseObject
    global_id_field :id
    field :manager_id, ID, null: true
    field :name, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
