# == Schema Information
#
# Table name: subscriptions
#
#  id                   :bigint           not null, primary key
#  cancel_at_period_end :boolean          not null
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
require 'rails_helper'

RSpec.describe Subscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
