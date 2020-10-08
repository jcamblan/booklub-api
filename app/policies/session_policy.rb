# frozen_string_literal: true

class SessionPolicy < ApplicationPolicy
  def show?
    return false unless authenticated?

    user.clubs.include?(record.club)
  end
end
