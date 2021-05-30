# frozen_string_literal: true

RSpec.describe Mutations::JoinClub, type: :request do
  let(:club) { Fabricate(:club, users: Fabricate.times(2, :user)) }

  let(:result) { response_body.dig('data', 'joinClub', 'club') }

  context 'when invitationCode matches a club' do
    let(:invitation_code) { club.invitation_code }

    context 'when current_user is not yet club_member' do
      let(:current_user) { Fabricate(:user) }

      it 'add current_user to club users' do
        do_graphql_request
        expect(mutation_errors).to be_empty
        expect(club.reload.users).to include(current_user)
      end
    end

    context 'when current_user is already club_member' do
      let(:current_user) { club.users.sample }

      it_behaves_like 'unauthorized user'
    end
  end

  context 'when invitationCode is unknown' do
    let(:invitation_code) { 'completely incorrect code' }
    let(:current_user) { Fabricate(:user) }

    it 'returns error' do
      do_graphql_request
      expect(mutation_errors).not_to be_empty
    end
  end

  def query
    <<-GRAPHQL
      mutation joinClub($input: JoinClubInput!) {
        joinClub(input: $input) {
          club {
            id
            name
            invitationCode
          }
          errors {
            message
            attribute
            error
          }
        }
      }
    GRAPHQL
  end

  def variables
    {
      input: {
        invitationCode: invitation_code
      }
    }
  end
end
