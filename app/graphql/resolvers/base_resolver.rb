# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    include ActionPolicy::GraphQL::Behaviour
    include ConnectionsHelper

    def current_user
      context[:current_user]
    end
  end
end
