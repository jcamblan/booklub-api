# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def me?
    authenticated? && record == user
  end

  def show?
    return false unless authenticated?
    return true if record == user

    User.joins(:clubs).where(clubs: { id: user.club_ids }).distinct.include?(record)
  end

  alias_rule :email?, :update?, to: :me?
end
