# $LOAD_PATH.unshift File.expand_path('..', __dir__)
#
# require 'bundler'
# Bundler.require :default
#
# ENV['RACK_ENV'] = 'test'
#
# require 'active_record'
# require 'database_cleaner'
# require 'slack-ruby-bot-server/rspec'
#
# db_config = YAML.safe_load(File.read(File.expand_path('../config/postgresql.yml', __dir__)), [], [], true)[ENV['RACK_ENV']]
# ActiveRecord::Tasks::DatabaseTasks.create(db_config)
# ActiveRecord::Base.establish_connection(db_config)
#
# RSpec.configure do |config|
#   config.around :each do |example.rb|
#     DatabaseCleaner.cleaning do
#       example.rb.run
#     end
#   end
# end