# == Schema Information
#
# Table name: user_profiles
#
#  id                  :bigint           not null, primary key
#  date_of_birth       :date             not null
#  first_name          :string           not null
#  last_name           :string           not null
#  phone_number        :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  experience_level_id :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_user_profiles_on_experience_level_id  (experience_level_id)
#  index_user_profiles_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (experience_level_id => experience_levels.id)
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
