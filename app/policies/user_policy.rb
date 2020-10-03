# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def me?
    authenticated? && record == user
  end

  alias_rule :email?, :show?, to: :me?
end
