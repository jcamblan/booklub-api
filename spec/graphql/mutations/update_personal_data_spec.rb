# frozen_string_literal: true

RSpec.describe Mutations::UpdatePersonalData, type: :request do # rubocop:disable Metrics/BlockLength
  let(:club) { Fabricate(:club, users: Fabricate.times(2, :user)) }

  let(:result) { json.dig('data', 'updatePersonalData', 'user') }
  let(:errors) { json.dig('data', 'updatePersonalData', 'errors') }

  let(:old_password) { 'toto' }
  let(:new_email) { Faker::Internet.email }
  let(:new_username) { Faker::Lorem.sentence }
  let(:new_password) { Faker::Lorem.sentence }
  let(:current_user) { Fabricate(:user, password: old_password) }

  context 'when updating password or email' do # rubocop:disable Metrics/BlockLength
    context 'when current_password is correct' do
      let(:input) do
        {
          email: new_email,
          username: new_username,
          password: new_password,
          currentPassword: old_password
        }
      end

      it 'updates user' do
        do_graphql_request
        current_user.reload
        expect(User.authenticate(current_user.email, new_password)).to be_truthy
        expect(current_user.email).to eq(new_email)
        expect(current_user.username).to eq(new_username)
      end
    end

    context 'when current_password is incorrect' do
      let(:input) do
        { password: new_password, currentPassword: 'tata' }
      end

      it 'returns error' do
        do_graphql_request
        expect(errors.pluck('error')).to include('invalid_current_password')
      end
    end

    context 'when current_password is absent' do
      let(:input) do
        { password: 'pataplouf' }
      end

      it 'returns error' do
        do_graphql_request
        expect(errors.pluck('error')).to include('invalid_current_password')
      end
    end
  end

  def query
    <<-GRAPHQL
      mutation updatePersonalData($input: UpdatePersonalDataInput!) {
        updatePersonalData(input: $input) {
          user {
            id
            username
            email
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
      input: input
    }
  end
end
