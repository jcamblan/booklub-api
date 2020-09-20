# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.implicit_order_column = :created_at

  def uuid
    GraphQL::Schema::UniqueWithinType.encode(self.class.name, id)
  end

  # after_commit on: :create do
  #   Uuid.create(id: id, resource: self) unless self.class.name == 'Uuid'
  # end

  # after_destroy do
  #   Uuid.find(id).destroy! unless self.class.name == 'Uuid'
  # end
end
