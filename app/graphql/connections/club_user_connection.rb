# frozen_string_literal: true

class Connections::ClubUserEdge < GraphQL::Relay::Edge
  delegate :session_count, :selection_count, :bonus_score, to: :club_user

  def club_user
    @club_user ||= ClubUser.find_by(club: parent, user: node)
  end
end

class Connections::ClubUserEdgeType < GraphQL::Types::Relay::BaseEdge
  node_type(Types::UserType)

  field :session_count, Int, null: true
  field :selection_count, Int, null: true
  field :bonus_score, Int, null: true
end

class Connections::ClubUserConnection < Connections::BaseConnection
  edge_type(Connections::ClubUserEdgeType, edge_class: Connections::ClubUserEdge)
end
