# == Schema Information
#
# Table name: allowlisted_jwts
#
#  id         :bigint           not null, primary key
#  aud        :string
#  exp        :datetime         not null
#  jti        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_allowlisted_jwts_on_jti      (jti) UNIQUE
#  index_allowlisted_jwts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe AllowlistedJwt, type: :model do
  let(:user) { User.create(email: 'test@test.com', password: 'password', encrypted_password: 'password', role: 'user') }

  let(:allowlisted_jwt) { AllowlistedJwt.create(aud: 'test_aud_string', exp: '2021-08-24', jti: 'test_jti_string', user_id: user.id) }

  it 'checks for the presence of values in required fields for allowed JWTs' do
    expect(allowlisted_jwt.aud).to eq('test_aud_string')
    expect(allowlisted_jwt.exp.to_s).to include('2021-08-24')
    expect(allowlisted_jwt.jti).to eq('test_jti_string')
    expect(allowlisted_jwt.user_id).to eq(user.id)
  end

  it 'checks the allow listed JWT is valid' do
    expect(allowlisted_jwt).to be_valid
  end 

  it 'checks the allow listed JWT is an instance of the class AllowlistedJWT' do
    expect(allowlisted_jwt).to be_an_instance_of(AllowlistedJwt)
  end

end
