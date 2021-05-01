# frozen_string_literal: true

# == Schema Information
#
# Table name: clubs
#
#  id              :uuid             not null, primary key
#  invitation_code :string           not null
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  manager_id      :uuid
#
# Indexes
#
#  index_clubs_on_invitation_code  (invitation_code) UNIQUE
#  index_clubs_on_name             (name)
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

  has_one_attached :banner

  belongs_to :manager, class_name: 'User'
  has_many :club_users, dependent: :destroy
  has_many :users, through: :club_users
  has_many :sessions, dependent: :destroy

  # == Validations =============================================================

  validates :invitation_code, presence: true, uniqueness: true
  validates :name, presence: true

  # == Scopes ==================================================================
  # == Callbacks ===============================================================

  before_validation :generate_invitation_code, on: :create
  after_commit :add_manager_to_users

  # == Class Methods ===========================================================
  # == Instance Methods ========================================================

  def banner_url
    return if banner.attachment.nil?

    banner&.service_url
  end

  # generate a new unique code and assign it to instance
  # save is still required.
  def generate_invitation_code
    codes = Club.pluck(:invitation_code)
    self.invitation_code = nil

    while invitation_code.blank?
      # Generate a 8 digits string as code
      code = format('%06d', rand(10**8))
      # Each code must be unique
      next if codes.include?(code)

      self.invitation_code = code
    end

    self
  end

  # Automatically add club manager to club users list through callback
  def add_manager_to_users
    users << manager unless users.include?(manager)
  end
end
