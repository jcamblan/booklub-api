# frozen_string_literal: true

class ApplicationController < ActionController::API
  def current_user
    return unless doorkeeper_token

    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
  end
end
