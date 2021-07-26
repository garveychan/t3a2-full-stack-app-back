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

  let(:experiencelevel) { ExperienceLevel.create(experience_level: 'novice') }

  let(:user) { User.create(email: 'test@test.com', password: 'password', encrypted_password: 'password', role: 'user') }

  let(:user_profile) { UserProfile.create(date_of_birth: '1992-08-23', first_name: 'Jane', last_name: 'Smith', phone_number: '12345678', experience_level_id: experiencelevel.id, user_id: user.id) }

    it 'checks for the presence of values in required fields for user profile' do
      expect(user_profile.date_of_birth.to_s).to include('1992-08-23')
      expect(user_profile.first_name).to eq('Jane')
      expect(user_profile.last_name).to eq('Smith')
      expect(user_profile.phone_number).to eq('12345678')
      expect(user_profile.experience_level_id).to eq(experiencelevel.id)
      expect(user_profile.user_id).to eq(user.id)
    end

    it 'checks the user profile is valid' do
      expect(user_profile).to be_valid
    end 

    it 'checks the user profile is an instance of the class UserProfile' do
      expect(user_profile).to be_an_instance_of(UserProfile)
    end
    
  end
