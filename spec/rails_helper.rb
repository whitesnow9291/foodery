ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require "paperclip/matchers"
require "rspec/json_expectations"
require 'sidekiq/testing'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.render_views
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Paperclip::Shoulda::Matchers
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  VCR.configure do |config|
    config.cassette_library_dir = "./spec/fixtures/vcr_cassettes"
    config.hook_into :webmock
    config.configure_rspec_metadata!
    config.default_cassette_options = { record: :new_episodes }
  end

  FactoryGirl::SyntaxRunner.class_eval do
    include RSpec::Mocks::ExampleMethods
  end
end
