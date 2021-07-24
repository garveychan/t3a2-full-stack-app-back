require 'faker'
require 'open-uri'
require 'fileutils'

%w[Novice Intermediate Pro].each do |role|
  ExperienceLevel.create! do |e|
    e.experience_level = role
  end
end

Waiver.create! do |w|
  w.active = true
  w.version = '1.0'
  w.changelog = 'Initial Waiver!'
  w.content = "
  ### Acknowledgements

  - You acknowledge and accept that climbing/bouldering is a dangerous recreational activity with obvious risks. You are participating at your own risk.
  - One Up Bouldering provides a safe environment to all participants and utilises state of the art equipment to ensure the safety of all its members. However, as bouldering is inherently a dangerous recreational activity, it is a requirement that all participants sign the waiver below.
  - Participants under the age of 18 must have their parent or legal guardian fill out and sign the waiver below.
  - Bouldering may involve incidental and significant risks which may cause physical or psychological injuries and in extreme circumstances, death.
  - This waiver excludes any liability for the personal injury which might be incurred by One Up Bouldering, its employees, agents and representatives arising out of your voluntary participation in the activities offered at One Up Bouldering.
  - By completing this form, you will accept the terms and conditions and will be agreeing to exclude and limit One Up Bouldering’s liability.
  - You are not obligated to sign or waive the liability under this form, however, should you not agree to this waiver, One Up Bouldering may refuse to provide you with its services and access to the premises.

  ### Waiver

  - I have been advised of the risks and dangers of bouldering and wish to participate at my own risk of injury.
  - I understand that bouldering and the use of the equipment at One Up Bouldering could result in physical and psychological injuries and in extreme circumstances, death.
  - I do not suffer from any medical condition or any other condition that may affect my ability to participate in bouldering safely. I assume the risk of injury to my health and safety.
  - I agree not to participate in activities whilst under the influence of drugs of alcohol.
  - I understand and accept the responsibility to review and comply with the rules and regulations, including any changes to these, at One Up Bouldering.
  - I am aware that this waiver is ongoing and will continue to apply to all future occasions I participate with One Up Bouldering.
  - I am at least 18 years of age and have legal capacity to sign this form or I am a parent or legal guardian responsible for the participant who is under the age of 18 years old.
  - I hereby indemnify and release One Up Bouldering, its directors, its employees, agents and representatives involved in my participation of the recreational activities offered from any legal costs, demand, action or claim for compensation whether for personal injury or damage to property arising from my participation of the activities.
  "
  w.declaration = 'I have read and understood this form and the terms contained herein and have been provided with clarification on any concerns that I may have in relation to this.'
end

##################################

if Rails.env.development?

  # Purge empty folders created by Active Storage (local)
  Dir.glob(Rails.root.join('storage', '**', '*').to_s).sort_by(&:length).reverse.each do |x|
    FileUtils.rm_rf(x, secure: true) if File.directory?(x)
  end

  def image_fetcher
    URI.parse(Faker::Avatar.image).open
  rescue StandardError
    URI.parse('https://robohash.org/sitsequiquia.png?size=300x300&set=set1').open
  end

  20.times do |i|
    user = User.create({ email: Faker::Internet.unique.email,
                         password: 'password',
                         password_confirmation: 'password' })

    profile = UserProfile.new({ date_of_birth: Faker::Date.between(from: 50.years.ago, to: Date.today),
                                first_name: Faker::Name.unique.name.split.first,
                                last_name: Faker::Name.unique.name.split.last,
                                phone_number: Faker::Number.leading_zero_number(digits: 12),
                                experience_level_id: rand(1..3) })

    address = UserAddress.new({ city: Faker::Address.city,
                                country: 'Australia',
                                postcode: Faker::Number.between(from: 2000, to: 2500),
                                state: 'NSW',
                                street_address: Faker::Address.street_address })

    photo = UserPhoto.new
    photo.image.attach({
                         io: image_fetcher,
                         filename: "#{i}_faker_image.jpg"
                       })

    signed_waiver = SignedWaiver.new({
                                       waiver_id: 1,
                                       name: profile.first_name,
                                       signatureURI: 'data:image/png;base64,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'
                                     })

    signed_waiver.user = user
    profile.user = user
    address.user = user
    photo.user = user

    signed_waiver.save!
    profile.save!
    address.save!
    photo.save!
  end

  User.create!({ email: 'admin@test.com',
                 password: 'password',
                 password_confirmation: 'password',
                 role: 'admin' })
  User.create!({ email: 'user@test.com',
                 password: 'password',
                 password_confirmation: 'password' })
end
