# == Schema Information
#
# Table name: stripe_customer_ids
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :string           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_stripe_customer_ids_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe StripeCustomerId, type: :model do
  let(:user) { User.create(email: 'test@test.com', password: 'password', encrypted_password: 'password', role: 'user') }

  let(:stripe_customer_id) { StripeCustomerId.create(id: 88,
  customer_id: '99', user_id: user.id)}

    it 'checks for the presence of values in required fields for stripe customer ID ' do
      expect(stripe_customer_id.id).to eq(88)
      expect(stripe_customer_id.customer_id).to eq('99')
    end

    it 'checks the Stripe customer ID is valid' do
      expect(stripe_customer_id).to be_valid
    end 

    it 'checks the Stripe customer ID is an instance of the class StripeCustomerID' do
      expect(stripe_customer_id).to be_an_instance_of(StripeCustomerId)
    end
end
