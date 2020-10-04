# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def club_manager?
    record.manager == user
  end

  def join?
    authenticated? && !record.users.include?(user)
  end

  def club_member?
    authenticated? && record.users.include?(user)
  end

  alias_rule :create?, :list_mine?, to: :authenticated?
  alias_rule :reset_invitation_code?, :invitation_code?, to: :club_manager?
  alias_rule :users?, :show?, to: :club_member?
end
