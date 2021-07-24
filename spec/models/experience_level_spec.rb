# == Schema Information
#
# Table name: experience_levels
#
#  id               :bigint           not null, primary key
#  experience_level :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe ExperienceLevel, type: :model do

  let(:experiencelevel) { ExperienceLevel.create(experience_level: 'novice') }
  it 'checks for the presence of a valid value' do
    expect(experiencelevel.experience_level).to eq('novice')
  end

  it 'checks the experience level is valid' do
    expect(experiencelevel).to be_valid
  end

  it 'checks the experience level is an instance of the class ExperienceLevel' do
    expect(experiencelevel).to be_an_instance_of(ExperienceLevel)
  end

end
