# frozen_string_literal: true

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git
require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/puma'
require "capistrano/procfile"
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Systemd

set :rvm_ruby_version, '3.0.4'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
