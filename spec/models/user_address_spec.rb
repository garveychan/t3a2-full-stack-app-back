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
require 'rails_helper'

RSpec.describe UserAddress, type: :model do
  let(:user) { User.create(email: 'test@test.com', password: 'password', encrypted_password: 'password', role: 'user') }

  let(:useraddress) { UserAddress.create(city: 'Springfield', country: 'USA', postcode: '8008', state: 'Ohio', street_address: '742 Evergreen Terrace', user_id: user.id) }

  it 'checks for the presence of valid values' do
    expect(useraddress.city).to eq('Springfield')
    expect(useraddress.country).to eq('USA')
    expect(useraddress.postcode).to eq('8008')
    expect(useraddress.state).to eq('Ohio')
    expect(useraddress.street_address).to eq('742 Evergreen Terrace')
  end

  it 'checks the user address is valid' do
    expect(useraddress).to be_valid
  end

  it 'checks the user address is an instance of the class UserAddress' do
    expect(useraddress).to be_an_instance_of(UserAddress)
  end
  
end
