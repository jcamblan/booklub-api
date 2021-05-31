# frozen_string_literal: true

RSpec.describe 'oauth2 controller', type: :request do
  let(:application) { Fabricate(:application, confidential: false) }
  let(:user) { Fabricate(:user) }

  let(:params) do
    {
      username: user.email,
      password: user.password,
      client_id: application.uid,
      scopes: application.scopes,
      grant_type: 'password'
    }
  end

  it 'returns the right token' do
    post '/oauth/token', params: params

    expect(response_body.keys).to include('access_token')
    expect(response_body[:access_token])
      .to eq(Doorkeeper::AccessToken.where(resource_owner_id: user.id).last&.token)
  end
end
