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
require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:subscription) { Subscription.create(cancel_at_period_end: true, current_period_end: '2021-08-24', current_period_start: '2021-07-24', status: 'active', user_id: 1) }

    it 'checks for the presence of values in required fields for subscription profile' do
      expect(subscription.cancel_at_period_end).to be_truthy
      expect(subscription.current_period_end.to_s).to include('2021-08-24')
      expect(subscription.current_period_start.to_s).to include('2021-07-24')
      expect(subscription.status).to eq('active')
      expect(subscription.user_id).to eq(1)
    end

    it 'checks the subscription is valid' do
      expect(subscription).to be_valid
    end 

    it 'checks the subscription is an instance of the class Subscription' do
      expect(subscription).to be_an_instance_of(Subscription)
    end
end
