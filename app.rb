# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default

Dir[File.expand_path('config/initializers', __dir__) + '/**/*.rb'].sort.each do |file|
  require file
end


# require_relative 'lib/models'
# require_relative 'lib/events'
# require_relative 'slash_commands'
# require_relative 'lib/actions'
# require_relative 'lib/additional_modules'

require 'yaml'
require 'erb'
require 'date'
require_relative 'lib/classes/everything_needed'
["slash_commands", "models", "actions", "events", "modules", "block_actions"].map do |u|
  Dir[ "lib/#{u}/*.rb"].each {|file| require_relative "#{file}" }
end


ActiveRecord::Base.establish_connection(
  YAML.safe_load(
    ERB.new(
      File.read('config/postgresql.yml')
    ).result, [], [], true
  )[ENV['RACK_ENV']]
)

$everything_needed = EverythingNeeded.new
