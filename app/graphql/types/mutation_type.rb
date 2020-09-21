# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::SignIn
    field :create_club, mutation: Mutations::CreateClub
    field :register, mutation: Mutations::Register
  end
end
