# == Schema Information
#
# Table name: user_photos
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_photos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe UserPhoto, type: :model do
  let(:userphoto) { UserPhoto.create(user_id: 1) }

  it 'checks the photo is valid' do
    expect(userphoto).to be_valid
  end

  it 'checks the photo is an instance of the class Photo' do
    expect(userphoto).to be_an_instance_of(UserPhoto)
  end
end
