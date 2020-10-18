# frozen_string_literal: true

class SessionPolicy < ApplicationPolicy
  def club_member?
    return false unless authenticated?

    user.clubs.include?(record.club)
  end

  def participate?
    return false unless club_member?
    return false unless record.submission?

    record.submissions.where(user: user).empty?
  end

  alias_rule :show?, to: :club_member?
end
