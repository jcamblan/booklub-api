# frozen_string_literal: true

class Types::Edges::ClubUserEdgeType < GraphQL::Types::Relay::BaseEdge
  node_type(Types::UserType)

  field :session_count, Int, null: true
  field :selection_count, Int, null: true
  field :bonus_score, Int, null: true
end
