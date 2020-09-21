# frozen_string_literal: true

# == Schema Information
#
# Table name: clubs
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  manager_id :uuid
#
# Indexes
#
#  index_clubs_on_name  (name)
#
# Foreign Keys
#
#  fk_rails_...  (manager_id => users.id)
#
class Club < ApplicationRecord
  # == Constants ===============================================================
  # == Attributes ==============================================================
  # == Extensions ==============================================================
  # == Relationships ===========================================================

  belongs_to :manager, class_name: 'User'
  has_many :club_users, dependent: :destroy
  has_many :users, through: :club_users
  has_many :sessions, dependent: :destroy

  # == Validations =============================================================
  # == Scopes ==================================================================
  # == Callbacks ===============================================================
  # == Class Methods ===========================================================
  # == Instance Methods ========================================================
end
