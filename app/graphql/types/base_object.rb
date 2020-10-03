# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    include ActionPolicy::GraphQL::Behaviour
    ActionPolicy::GraphQL.authorize_raise_exception = false

    include ConnectionsHelper

    field_class Types::BaseField

    def current_user
      context[:current_user]
    end
  end
end
