# frozen_string_literal: true
#---------------------------------------
#require needed_libraries
require 'rspec'
require 'pry'
require 'factory_bot'
require 'active_record'
require 'faker'
require 'database_cleaner'
require 'capybara'
require 'selenium/webdriver'
require 'capybara/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  #---------------------------------------
  #FACTORY BOT SETUP
  config.include FactoryBot::Syntax::Methods

  # config.include Capybara::DSL
  #---------------------------------------
  #DATABASE CLEANUP
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation, except: %w[teams])
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean_with(:truncation, except: %w[teams])
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
require_relative 'helpers/login_helper'

Capybara.configure do |c|
  c.default_driver = :selenium_headless
end

ActiveRecord::Base.establish_connection(
  YAML.safe_load(
    ERB.new(
      File.read('config/postgresql.yml')
    ).result, [], [], true
  )['test']
)


require_relative '../importing_files'
require_relative 'factories/standup_check_factory'
