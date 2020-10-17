# frozen_string_literal: true

class SessionPolicy < ApplicationPolicy
  def club_member?
    return false unless authenticated?

    user.clubs.include?(record.club)
  end

  def participate?
    club_member? && record.submissions.find_by(user: user).nil?
  end

  alias_rule :show?, :create?, to: :club_member?
end
