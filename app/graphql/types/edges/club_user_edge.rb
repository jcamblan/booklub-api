# frozen_string_literal: true

class Types::Edges::ClubUserEdge < GraphQL::Relay::Edge
  delegate :session_count, :selection_count, :bonus_score, to: :club_user

  def club_user
    @club_user ||= ClubUser.find_by(club: parent, user: node)
  end
end
