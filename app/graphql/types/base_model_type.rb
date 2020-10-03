module Types
  class BaseModelType < Types::BaseObject
    def self.authorized?(object, context)
      super && allowed_to?(:show?, object, context: { user: context[:current_user] })
    end
  end
end
