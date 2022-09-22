# frozen_string_literal: true

set :rvm_type, :user
set :rvm_custom_path, '~/.rvm'
server '167.99.132.241',
       roles: %w[app web db],
       ssh_options: {
         user: 'deploy',
         port: 22
       }
set :application, 'wstaniobot'
set :user, 'deploy'
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :deploy_env, 'production'
set :rails_env, 'production'
set :branch, ENV['BRANCH'] || 'master'
set :puma_threads,    [1, 6]
set :puma_workers,    1
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_systemctl_user, fetch(:user)
