# frozen_string_literal: true

class BooklubApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST
  use GraphQL::Execution::Errors

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  default_max_page_size 20

  rescue_from ActionPolicy::Unauthorized do |err|
    raise GraphQL::ExecutionError.new(
      # use result.message (backed by i18n) as an error message
      err.result.message,
      extensions: {
        # use GraphQL error extensions to provide more context
        code: 'Unauthorized',
        fullMessages: err.result.reasons.full_messages,
        details: err.result.reasons.details
      }
    )
  end

  # Create UUIDs by joining the type name & ID, then base64-encoding it
  def self.id_from_object(object, type_definition, _query_ctx)
    GraphQL::Schema::UniqueWithinType.encode(type_definition.graphql_name, object.id)
  end

  # Find object base on based on `type_name` and `item_id` from UUID
  def self.object_from_id(id, _query_ctx)
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    type_name.constantize.find item_id
  end

  def self.resolve_type(_type, obj, _ctx)
    "Types::#{obj.class.name}Type".constantize
  rescue NameError => e
    raise "#{e.name} is not a valid type"
  end
end
