# == Schema Information
#
# Table name: waivers
#
#  id          :bigint           not null, primary key
#  active      :boolean          not null
#  changelog   :text             not null
#  content     :text             not null
#  declaration :text             not null
#  version     :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Waiver < ApplicationRecord
  # Associations
  has_many :signed_waivers, dependent: :nullify

  # Validations
  validates :active, presence: true
  validates :version, presence: true, length: { maximum: 100 }
  validates :changelog, presence: true, length: { maximum: 1000 }
  validates :content, presence: true, length: { maximum: 5000 }
  validates :declaration, presence: true, length: { maximum: 1000 }
end
