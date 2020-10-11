# frozen_string_literal: true

class Connections::SubmissionsEdgeType < GraphQL::Types::Relay::BaseEdge
  node_type(Types::SubmissionType)
end

class Connections::SubmissionsConnection < Connections::BaseConnection
  edge_type(Connections::SubmissionsEdgeType)
end
