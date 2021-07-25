# == Schema Information
#
# Table name: signed_waivers
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  signatureURI :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  waiver_id    :bigint           not null
#
# Indexes
#
#  index_signed_waivers_on_user_id    (user_id)
#  index_signed_waivers_on_waiver_id  (waiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#  fk_rails_...  (waiver_id => waivers.id)
#
class SignedWaiver < ApplicationRecord
  # Validations
  validates :name, presence: true, length: { maximum: 100 }
  validates :signatureURI, presence: true

  # Associations
  belongs_to :user
  belongs_to :waiver
end
