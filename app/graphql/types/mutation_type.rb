# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # == User management =======================================================

    field :register, mutation: Mutations::Register
    field :sign_in, mutation: Mutations::SignIn
    field :update_personal_data, mutation: Mutations::UpdatePersonalData

    # == Club management =======================================================

    field :create_club, mutation: Mutations::CreateClub
    field :update_club, mutation: Mutations::UpdateClub
    field :join_club, mutation: Mutations::JoinClub
    field :reset_club_invitation_code, mutation: Mutations::ResetClubInvitationCode

    # == Session management ====================================================

    field :create_session, mutation: Mutations::CreateSession
    field :start_session_draw, mutation: Mutations::StartSessionDraw
    field :conclude_session, mutation: Mutations::ConcludeSession
    field :archive_session, mutation: Mutations::ArchiveSession
    field :create_submission, mutation: Mutations::CreateSubmission
    field :note_session, mutation: Mutations::NoteSession
  end
end
