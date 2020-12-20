# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include ActionPolicy::GraphQL::Behaviour
    include Dry::Effects.Interrupt(:validation_error)

    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    # @return [User] the current user
    def current_user
      context[:current_user]
    end

    # Wraps block with `RunResolverWithValidation`
    def with_validation!(path: [])
      Mutations::ValidationResolver.new.call do
        yield
      rescue ActiveRecord::RecordInvalid => e
        validation_error validation_error_data(e.record.errors, path: path)
      rescue ActiveRecord::RecordNotFound => e
        validation_error [{ error: 'RecordNotFound', message: e.message, path: [] }]
      end
    end

    def error_path!(path = [])
      yield
    rescue ActiveRecord::RecordInvalid => e
      validation_error validation_error_data(e.record.errors, path: path)
    end

    # @param [ActiveModel::Errors]
    #
    # @return [Hash]
    def validation_error_data(errors, path: [])
      errors.map do |attribute, message|
        path = Array(path).map { |p| p.to_s.camelize(:lower) }
        error = errors.details.dig(attribute, 0, :error)

        build_validation_error(attribute, message, error, path: path)
      end
    end

    def build_validation_error(attribute, message, error, path: [])
      path = Array(path).map { |p| p.to_s.camelize(:lower) }

      {
        path: ['attributes', *path, attribute.to_s.camelize(:lower)],
        message: message,
        attribute: attribute.to_s.camelize(:lower),
        error: error
      }
    end

    def blobify(file)
      ActiveStorage::Blob.create_and_upload!(
        io: file,
        filename: file.original_filename,
        content_type: file.content_type
      )
    end
  end
end
