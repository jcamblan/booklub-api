# frozen_string_literal: true

RSpec.describe Mutations::ResetClubInvitationCode, type: :request do # rubocop:disable Metrics/BlockLength
  let(:manager) { Fabricate(:user) }
  let(:club) { Fabricate(:club, manager: manager) }
  let!(:initial_code) { club.invitation_code }

  let(:result) { response_body.dig('data', 'resetClubInvitationCode', 'club') }

  context 'when current_user is the club manager' do
    let(:current_user) { manager }

    it 'reset club invitation code' do
      do_graphql_request
      expect(club.reload.invitation_code).not_to eq(initial_code)
    end

    it 'returns no error' do
      do_graphql_request
      expect(mutation_errors).to be_empty
    end
  end

  context 'when current_user is not the club_manager' do
    let(:current_user) { Fabricate(:user) }

    before { club.users << current_user }

    it_behaves_like 'unauthorized user'

    it 'does not change the invitation code' do
      do_graphql_request
      expect(club.reload.invitation_code).to eq(initial_code)
    end
  end

  context 'when current_iser is not club member' do
    let(:current_user) { Fabricate(:user) }

    it 'returns nil' do
      do_graphql_request
      expect(response_body.dig('data', 'resetClubInvitationCode')).to be nil
    end
  end

  def query
    <<-GRAPHQL
      mutation resetClubInvitationCode($input: ResetClubInvitationCodeInput!) {
        resetClubInvitationCode(input: $input) {
          club {
            id
            name
            invitationCode
          }
          errors {
            path
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
        clubId: club.uuid
      }
    }
  end
end
