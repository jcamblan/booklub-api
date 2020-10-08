# frozen_string_literal: true

class Types::Edges::ClubUserEdgeType < GraphQL::Types::Relay::BaseEdge
  node_type(Types::UserType)

  field :sessionCount, Int, null: true
  field :selectionCount, Int, null: true
  field :bonusScore, Int, null: true
end
