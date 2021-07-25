# == Schema Information
#
# Table name: waivers
#
#  id          :bigint           not null, primary key
#  active      :boolean          not null
#  changelog   :text             not null
#  content     :text             not null
#  declaration :text             not null
#  version     :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Waiver, type: :model do

  let(:waiver) { Waiver.create(active: true, changelog: 'Updated in response to legal changes', content: 'Sample waiver text', version: '1.0') }
    it 'checks for the presence of valid values' do
      expect(waiver.active).to be_truthy
      expect(waiver.changelog).to eq('Updated in response to legal changes')
      expect(waiver.content).to eq('Sample waiver text')
      expect(waiver.version).to eq('1.0')
    end

  it 'checks the waiver is valid' do
    expect(waiver).to be_valid
  end

  it 'checks the waiver is an instance of the class Waiver' do
    expect(waiver).to be_an_instance_of(Waiver)
  end
end
