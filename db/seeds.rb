if Rails.env.development?

  %w[admin user].each do |role|
    User.create! do |u|
      u.email = "#{role}@test.com"
      u.password = 'password'
      u.password_confirmation = 'password'
      u.role = role.to_s
    end
  end

end
