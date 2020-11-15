# frozen_string_literal: true

class BookPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end
end
