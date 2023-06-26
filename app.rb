# frozen_string_literal: true

require 'bundler'
Bundler.require :default

Dir[File.expand_path('config/initializers', __dir__) + '/**/*.rb'].sort.each do |file|
  require file
end

require 'yaml'
require 'erb'
require 'date'
require_relative 'lib2/load_env'
require 'airrecord'

$ENV = LoadENV.new
Dir['lib2/**/*.rb'].each { |file| require_relative "#{file}" }

ActiveRecord::Base.establish_connection(
  YAML.safe_load(
    ERB.new(
      File.read('config/postgresql.yml')
    ).result, aliases: true
  )[$ENV.get('RACK_ENV')]
)
