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
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development do
  gem 'listen', '~> 3.3'
end

# Custom Gems
#############################################################################################

# Amazon Web Services Image Upload
gem 'aws-sdk-s3', require: false
gem 'active_storage_validations'

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
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0.0'
	gem 'brakeman'
	gem 'bullet'
end

# Development
group :development do
	gem 'rubocop-rails', require: false
  gem 'rubocop', require: false
  gem 'annotate'
end