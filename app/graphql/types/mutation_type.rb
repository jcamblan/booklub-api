# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_club, mutation: Mutations::CreateClub
    field :register, mutation: Mutations::Register
  end
end
