# frozen_string_literal: true

class Types::Edges::SubmissionsEdgeType < GraphQL::Types::Relay::BaseEdge
  node_type(Types::SubmissionType)
end
