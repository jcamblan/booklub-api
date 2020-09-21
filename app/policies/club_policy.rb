# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  alias_rule :create?, to: :authenticated?
end
