# == Schema Information
#
# Table name: waivers
#
#  id         :bigint           not null, primary key
#  active     :boolean          not null
#  changelog  :text             not null
#  content    :text             not null
#  version    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Waiver < ApplicationRecord
end
