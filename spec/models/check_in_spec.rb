# == Schema Information
#
# Table name: check_ins
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_check_ins_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe CheckIn, type: :model do
  let(:checkin) { CheckIn.create }

  it 'checks the check-in is valid' do
    expect(checkin).to be_valid
  end

  it 'checks the check-in is an instance of the class CheckIn' do
    expect(checkin).to be_an_instance_of(CheckIn)
  end

end
