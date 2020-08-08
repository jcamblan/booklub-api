# frozen_string_literal: true

Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  resource_owner_from_credentials do
    user = User.find_by(email: params[:username])
    User.authenticate(user&.email, params[:password])
  end

  api_only

  access_token_expires_in 24.hours

  use_refresh_token

  enforce_configured_scopes

  grant_flows %w[password]
end
