# == Schema Information
#
# Table name: user_addresses
#
#  id             :bigint           not null, primary key
#  city           :string           not null
#  country        :string           not null
#  postcode       :string           not null
#  state          :string           not null
#  street_address :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_user_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class UserAddress < ApplicationRecord
end
