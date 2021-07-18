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
class User < ApplicationRecord
end
