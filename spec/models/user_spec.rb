# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  role       :enum             default("user"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_role  (role)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
