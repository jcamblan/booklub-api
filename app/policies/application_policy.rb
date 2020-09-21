# frozen_string_literal: true

# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  authorize :user, allow_nil: true

  def authenticated?
    user.present?
  end
end
