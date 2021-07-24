require 'faker'

%w[Novice Intermediate Pro].each do |role|
  ExperienceLevel.create! do |e|
    e.experience_level = role
  end
end

if Rails.env.development?
  20.times do
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
    profile.user = user
    address.user = user
    profile.save!
    address.save!
  end

  User.create!({ email: 'admin@test.com',
                 password: 'password',
                 password_confirmation: 'password',
                 role: 'admin' })
  User.create!({ email: 'user@test.com',
                 password: 'password',
                 password_confirmation: 'password' })
end
