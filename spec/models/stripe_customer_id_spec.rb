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
  pending "add some examples to (or delete) #{__FILE__}"
end
