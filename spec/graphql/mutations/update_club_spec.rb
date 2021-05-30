# frozen_string_literal: true

RSpec.describe Mutations::UpdateClub, type: :request do
  let(:club) { Fabricate(:club, users: Fabricate.times(2, :user)) }

  let(:result) { response_body.dig('data', 'updateClub', 'club') }
  let(:name) { Faker::Lorem.sentence }

  context 'when current_user is club manager' do
    let(:current_user) { club.manager }

    it 'updates club' do
      do_graphql_request
      expect(result['name']).to eq(name)
    end
  end

  context 'when current_user is not club manager' do
    let(:current_user) { club.users.where.not(id: club.manager_id).first }

    it_behaves_like 'unauthorized user'
  end

  def query
    <<-GRAPHQL
      mutation updateClub($input: UpdateClubInput!) {
        updateClub(input: $input) {
          club {
            id
            name
            invitationCode
            bannerUrl
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
        clubId: club.uuid,
        name: name
      }
    }
  end
end
