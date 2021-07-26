# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :enum             default("user"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role                  (role)
#
class User < ApplicationRecord
  # Associations
  has_one :user_profile, dependent: :destroy
  has_one :user_address, dependent: :destroy
  has_one :user_photo, dependent: :destroy
  has_one :stripe_customer_id, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_many :check_ins, dependent: :destroy
  has_many :allowlisted_jwts, dependent: :destroy
  has_many :signed_waivers, dependent: :destroy

  # User Role
  # user.admin_role? user.user_role?
  enum role: { admin: 'admin', user: 'user' }, _suffix: true, _default: :user

  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :encrypted_password, presence: true
  validates_associated :user_profile
  validates_associated :user_address
  validates_associated :user_photo

  # Scope Extension
  scope :checked_in_after, ->(threshold) { joins(:check_ins).where('check_ins.created_at >= ?', threshold).distinct }

  # Authentication
  include Devise::JWT::RevocationStrategies::Allowlist
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    { 'id' => id,
      'email' => email,
      'role' => role,
      'profileComplete' => profile_complete?,
      'stripeCustomer' => customer_created? }
  end

  def profile_complete?
    user_role? ? !!(user_profile && user_address && user_photo && signed_waivers) : true
  end

  def customer_created?
    user_role? ? !!stripe_customer_id : true
  end
end
