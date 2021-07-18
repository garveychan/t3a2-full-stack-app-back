# == Schema Information
#
# Table name: user_profiles
#
#  id                  :bigint           not null, primary key
#  date_of_birth       :date             not null
#  first_name          :string           not null
#  last_name           :string           not null
#  phone_number        :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  experience_level_id :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_user_profiles_on_experience_level_id  (experience_level_id)
#  index_user_profiles_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (experience_level_id => experience_levels.id)
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class UserProfile < ApplicationRecord
  # Associations
  belongs_to :user, touch: true
  belongs_to :experience_level

  # Validations
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
  validates :phone_number, presence: true, length: { maximum: 50 }
  validates :date_of_birth, presence: true
  validate :date_of_birth_has_passed
  validate :phone_number_format

  private

  # Custom Validations
  def date_of_birth_has_passed
    errors.add(:date_of_birth, " can't be in the future") if date_of_birth.present? && date_of_birth > Time.zone.today
  end

  def phone_number_format
    errors.add(:phone_number, ' must be valid') unless /\A[+]?\d+\z/ === phone_number
  end
end
