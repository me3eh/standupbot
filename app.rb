# frozen_string_literal: true


require 'bundler'
Bundler.require :default

Dir[File.expand_path('config/initializers', __dir__) + '/**/*.rb'].sort.each do |file|
  require file
end

puts '1'
require 'yaml'
puts '2'
require 'erb'
puts '3'
require 'date'
puts '4'
require 'pp'
puts '5'
require_relative 'importing_files'
puts '6'
# ENV['RACK_ENV'] = 'test'
puts '7'
# puts "dyyyyyy" + ENV['RACK_ENV']
["slash_commands", "actions", "events", "modules", "block_actions"].map do |u|
  Dir[ "lib/#{u}/*.rb"].each {|file| require_relative "#{file}" }
end

$ENV = LoadENV.new
$ENV.get(:RACK_ENV)

ActiveRecord::Base.establish_connection(
  YAML.safe_load(
    ERB.new(
      File.read('config/postgresql.yml')
    ).result, aliases: true
  )[ENV['RACK_ENV']]
)

#$everything_needed = EverythingNeeded.new
# puts '8'
# db_config = YAML.load_file('config/postgresql.yml')
# Team.establish_connection(db_config[ENV['development']])
# Standup_Check.establish_connection(db_config[ENV['RACK_ENV']])
# Free_From_Standup.establish_connection(db_config[ENV['RACK_ENV']])
