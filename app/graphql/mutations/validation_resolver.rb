# frozen_string_literal: true

# Effect to handle validation errors automatically
class Mutations::ValidationResolver
  include Dry::Effects::Handler.Interrupt(:validation_error, as: :catch_error)

  def call(&block)
    error, result = catch_error(&block)

    error ? { errors: result } : result
  end
end
