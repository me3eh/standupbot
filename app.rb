# frozen_string_literal: true


require 'bundler'
Bundler.require :default

Dir[File.expand_path('config/initializers', __dir__) + '/**/*.rb'].sort.each do |file|
  require file
end


require 'yaml'
require 'erb'
require 'date'
require 'pp'
require_relative 'lib/help/load_env'
require 'airrecord'

$ENV = LoadENV.new
Dir[ "lib2/**/*.rb"].each {|file| require_relative "#{file}" }



ActiveRecord::Base.establish_connection(
  YAML.safe_load(
    ERB.new(
      File.read('config/postgresql.yml')
    ).result, aliases: true
  )[$ENV.get('RACK_ENV')]
)

# $everything_needed = EverythingNeeded.new
# puts '8'
# db_config = YAML.load_file('config/postgresql.yml')
# Team.establish_connection(db_config[ENV['development']])
# Standup_Check.establish_connection(db_config[ENV['RACK_ENV']])
# Free_From_Standup.establish_connection(db_config[ENV['RACK_ENV']])

# ["slash_commands", "actions", "events", "modules", "block_actions"].each do |types_of_directory|
#   files_in_lib = Dir.glob("lib/#{types_of_directory}/*.rb")
#   directory_in_directory = Dir.glob("lib/#{types_of_directory}/**/*/")
#   all_files_to_include = files_in_lib - directory_in_directory.map{ |u| u[0..u.size-2] }
#   all_files_to_include.each do |file|
#     require_relative "#{file}"
#   end
# end
