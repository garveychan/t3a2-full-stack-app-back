source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Default Gems
#############################################################################################

ruby '2.7.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development do
  gem 'listen', '~> 3.3'
end

# Custom Gems
#############################################################################################

# Serializer for JSON responses
gem 'active_model_serializers'

# Amazon Web Services Image Upload
gem 'active_storage_validations'
gem 'aws-sdk-s3', require: false

# Cross Origin Resource Sharing
gem 'rack-cors'

# Stripe Payments Integration
gem 'stripe'

# Authentication/Authorisation
gem 'devise'
gem 'devise-jwt'
gem 'pundit'

# Development & Testing
group :development, :test do
  gem 'brakeman'
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'rspec-rails', '~> 5.0.0'
end

# Development
group :development do
  gem 'annotate'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end
