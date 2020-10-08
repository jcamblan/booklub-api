# frozen_string_literal: true

class Types::Connections::ClubUserConnection < Types::Connections::BaseConnection
  edge_type(Types::Edges::ClubUserEdgeType, edge_class: Types::Edges::ClubUserEdge)
end
