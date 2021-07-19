FactoryBot.define do
  factory :user do
    role { 'user' }
    email_address { 'user@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :admin do
    role { 'admin' }
    email_address { 'admin@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
