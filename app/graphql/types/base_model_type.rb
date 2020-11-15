# frozen_string_literal: true

module Types
  class BaseModelType < Types::BaseObject
    def self.authorized?(object, context)
      super && allowed_to?(:show?, object, context: { user: current_user })
    end
  end
end
