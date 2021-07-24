# == Schema Information
#
# Table name: signatures
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  signed_waiver_id :bigint           not null
#
# Indexes
#
#  index_signatures_on_signed_waiver_id  (signed_waiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (signed_waiver_id => signed_waivers.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe Signature, type: :model do
  let(:signature) { Signature.create }

  it 'checks the signature is valid' do
    expect(signature).to be_valid
  end

  it 'checks the signature is an instance of the class Signature' do
    expect(signature).to be_an_instance_of(Signature)
  end
end
