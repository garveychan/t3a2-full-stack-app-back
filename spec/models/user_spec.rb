# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :enum             default("user"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role                  (role)
#
require 'rails_helper'

# KR, 23Jul2021: Test will fail because the dependencies have not been addressed yet 

RSpec.describe User, type: :model do

  # let(:user_profile) { UserProfile.create(date_of_birth: Date.today, first_name: 'Jane', last_name: 'Smith', phone_number: '12345678', experience_level_id: 1, user_id: 1)}

  let(:user) { User.create(email: 'test@test.com', password: 'password', encrypted_password: 'password', role: 'user') }
    it 'checks for the presence of valid values in required login fields for email and password' do
      expect(user.email).to eq('test@test.com')
      expect(user.password).to eq('password')
      expect(user.encrypted_password).to eq('password')
      expect(user.role).to eq('user')
    end

    it 'checks the user is valid' do
      expect(user).to be_valid
    end

    it 'checks the user is an instance of the class User' do
      expect(user).to be_an_instance_of(User)
    end
end
