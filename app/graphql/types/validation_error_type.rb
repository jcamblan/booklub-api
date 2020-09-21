# frozen_string_literal: true

class Types::ValidationErrorType < Types::BaseObject
  description 'A validation error'

  field :path, String, null: false
  field :message, String, null: false
  field :attribute, String, null: true
  field :error, String, null: true
end
