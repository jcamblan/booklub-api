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

  def note?
    return false if record.state_precedes?(:reading)
    return false if record.selected_book_id.nil?

    record.users.include?(user)
  end

  alias_rule :show?, to: :club_member?
end
