# frozen_string_literal: true

class GraphqlController < ActionController::API
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute # rubocop:disable Metrics/MethodLength
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user
    }
    result = BooklubApiSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param) # rubocop:disable Metrics/MethodLength
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    render json: {
      errors: [{ message: error.message, backtrace: error.backtrace }], data: {}
    }, status: :internal_server_error
  end

  def current_user
    return unless doorkeeper_token

    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
  end
end
