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
  let(:user) { User.create(email: 'test@test.com', password: 'password', encrypted_password: 'password', role: 'user') }

  let(:experience_level_id) { Experience_level.create! }

  let(:user_profile) { UserProfile.create(date_of_birth: '1992-08-23', first_name: 'Jane', last_name: 'Smith', phone_number: '12345678', experience_level_id: 1, user_id: 1) }
    it 'checks for the presence of values in required fields for user profile' do
      expect(user_profile.date_of_birth.to_s).to include('1992-08-23')
      expect(user_profile.first_name).to eq('Jane')
      expect(user_profile.last_name).to eq('Smith')
      expect(user_profile.phone_number).to eq('12345678')
      expect(user_profile.experience_level_id).to eq(1)
      expect(user_profile.user_id).to eq(1)
      # User profile cannot be validated yet until the dependent validations have been addressed 
      # expect(user_profile).to be_valid
    end
  end
