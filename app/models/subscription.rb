# == Schema Information
#
# Table name: subscriptions
#
#  id                   :bigint           not null, primary key
#  cancel_at_period_end :boolean          not null
#  current_period_end   :date             not null
#  current_period_start :date             not null
#  status               :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  subscription_id      :string           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class Subscription < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :subscription_id, presence: true
  validates :status, presence: true
  validates :cancel_at_period_end, presence: true
  validates :current_period_start, presence: true
  validates :current_period_end, presence: true
end
