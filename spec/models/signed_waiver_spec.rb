# == Schema Information
#
# Table name: signed_waivers
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  signatureURI :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  waiver_id    :bigint           not null
#
# Indexes
#
#  index_signed_waivers_on_user_id    (user_id)
#  index_signed_waivers_on_waiver_id  (waiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#  fk_rails_...  (waiver_id => waivers.id)
#
require 'rails_helper'

RSpec.describe SignedWaiver, type: :model do
  let(:user) { User.create(email: 'test@test.com', password: 'password', encrypted_password: 'password', role: 'user') }

  let(:waiver) { Waiver.create(active: true, changelog: 'Updated in response to legal changes', content: 'Sample waiver text', declaration: 'test of declaration text', version: '1.0') }

  let(:signed_waiver) { SignedWaiver.create(name: 'Jane', signatureURI: 'test of signature URI', user_id: user.id, waiver_id: waiver.id)}

    it 'checks for the presence of values in required fields for signed waiver' do
      expect(signed_waiver.name).to include('Jane')
      expect(signed_waiver.signatureURI).to include('test of signature URI')
      expect(signed_waiver.user_id).to eq(user.id)
      expect(signed_waiver.waiver_id).to eq(waiver.id)
    end

    it 'checks the signed waiver is valid' do
      expect(signed_waiver).to be_valid
    end 

    it 'checks the signed waiver is an instance of the class SignedWaiver' do
      expect(signed_waiver).to be_an_instance_of(SignedWaiver)
    end
end
