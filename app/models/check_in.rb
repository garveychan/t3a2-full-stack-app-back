# == Schema Information
#
# Table name: check_ins
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_check_ins_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class CheckIn < ApplicationRecord
  # Assocations
  belongs_to :user

  # Scope Extensions
  scope :today, -> { where('created_at >= ?', Time.zone.now.beginning_of_day) }
end
