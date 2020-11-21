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
    field :sessions, SessionType.connection_type, null: true do
      argument :filter, Types::SessionFilterInput, required: false
    end
    field :current_session, Types::SessionType, null: true
    field :banner_url, String, null: true

    expose_authorization_rules :create_session?

    def current_session
      object.sessions.order(created_at: :desc)
            .find_by(state: %w[submission draw reading conclusion])
    end

    def sessions(**args)
      res = connection_with_arguments(object.sessions, args)
      res = apply_filter(res, args[:filters])
    end
  end
end
