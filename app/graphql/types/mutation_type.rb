# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :note_session, mutation: Mutations::NoteSession
    field :reset_club_invitation_code, mutation: Mutations::ResetClubInvitationCode
    field :sign_in, mutation: Mutations::SignIn
    field :create_club, mutation: Mutations::CreateClub
    field :join_club, mutation: Mutations::JoinClub
    field :register, mutation: Mutations::Register
    field :create_session, mutation: Mutations::CreateSession
    field :create_submission, mutation: Mutations::CreateSubmission
  end
end
