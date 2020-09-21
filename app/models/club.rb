# frozen_string_literal: true

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
