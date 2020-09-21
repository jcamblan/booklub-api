# frozen_string_literal: true

class User < ApplicationRecord
  # == Constants ===============================================================
  # == Attributes ==============================================================
  # == Extensions ==============================================================

  include Clearance::User

  # == Relationships ===========================================================

  # rubocop:disable Rails/InverseOf
  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all
  # rubocop:enable Rails/InverseOf

  has_many :club_users, dependent: :destroy
  has_many :clubs, through: :club_users
  has_many :submissions, dependent: :destroy

  # == Validations =============================================================

  validates :email, uniqueness: { case_sensitive: false }

  # == Scopes ==================================================================
  # == Callbacks ===============================================================
  # == Class Methods ===========================================================
  # == Instance Methods ========================================================
end
