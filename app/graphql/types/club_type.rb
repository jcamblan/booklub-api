# frozen_string_literal: true

module Types
  class ClubType < Types::BaseModelType
    global_id_field :id
    field :name, String, null: true
    field :invitation_code, String, null: true, authorize_field: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :users, Connections::ClubUserConnection, null: true, authorize_field: true
    field :manager, UserType, null: true
    field :sessions, SessionType.connection_type, null: true
    field :current_session, Types::SessionType, null: true

    def current_session
      object.sessions.find_by(state: %w[submission draw reading conclusion])
    end
  end
end
