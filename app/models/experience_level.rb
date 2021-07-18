# == Schema Information
#
# Table name: experience_levels
#
#  id               :bigint           not null, primary key
#  experience_level :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class ExperienceLevel < ApplicationRecord
  # Associations
  has_many :user_profiles, dependent: :nullify

  # Validations
  validates :experience_level, presence: true, length: { maximum: 50 }
end
