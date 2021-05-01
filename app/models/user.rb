# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :uuid             not null, primary key
#  confirmation_token :string(128)
#  email              :string           not null
#  encrypted_password :string(128)      not null
#  remember_token     :string(128)      not null
#  username           :string           default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email           (email) UNIQUE
#  index_users_on_remember_token  (remember_token)
#
class User < ApplicationRecord
  # == Constants ===============================================================
  # == Attributes ==============================================================

  attr_accessor :current_password

  # == Extensions ==============================================================

  include Clearance::User

  # == Relationships ===========================================================

  has_one_attached :avatar

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

  has_many :managed_clubs, dependent: :destroy,
                           foreign_key: :manager_id,
                           class_name: 'Club',
                           inverse_of: :manager
  has_many :club_users, dependent: :destroy
  has_many :clubs, through: :club_users
  has_many :sessions, through: :clubs
  has_many :submissions, dependent: :destroy
  has_many :notes, dependent: :destroy

  # == Validations =============================================================

  validates :email, uniqueness: { case_sensitive: false }

  validate :check_password, on: :update

  # == Scopes ==================================================================
  # == Callbacks ===============================================================
  # == Class Methods ===========================================================
  # == Instance Methods ========================================================

  def avatar_url
    return if avatar.attachment.nil?

    avatar&.service_url
  end

  def check_password
    return if password.nil? && !email_changed?
    return if User.authenticate(email_in_database, current_password || password)

    errors.add(:password, :invalid_current_password)
  end
end
