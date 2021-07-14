# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default

Dir[File.expand_path('config/initializers', __dir__) + '/**/*.rb'].sort.each do |file|
  require file
end


require_relative 'lib/models'
require_relative 'lib/events'
require_relative 'lib/slash_commands'
require_relative 'lib/actions'
require_relative 'lib/additional_modules'

require 'yaml'
require 'erb'


ActiveRecord::Base.establish_connection(
  YAML.safe_load(
    ERB.new(
      File.read('config/postgresql.yml')
    ).result, [], [], true
  )[ENV['RACK_ENV']]
)

$everything_needed = Everything_Needed.new
