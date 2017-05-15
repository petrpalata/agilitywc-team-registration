require 'bundler/capistrano'
require 'rvm/capistrano'
set :application, "team_registration"
#set :repository, "ssh://petr@kacr.info:10522/home/git/repositories/team_registration.git"
set :repo_url, 'git@bitbucket.org:petrpalata/team_registration.git'
set :branch, "master"
#set :deploy_via, :remote_cache
set :scm, :git
set :rvm_ruby_string, 'ree-1.8.7-2011.12'
set :rvm_type, :system
set :bundle_flags,    "--deployment"
set :bundle_without,  []
set :use_sudo, false

load 'deploy/assets'

default_run_options[:pty] = true

set :deploy_to, '/home/kwertan/team_registration'

set :ssh_options, { :forward_agent => true }

role :assets, "agility2017.cz"
role :app, "agility2017.cz"
role :web, "agility2017.cz"
role :db,  "agility2017.cz", :primary => true

set :user, "kwertan"

namespace :passenger do
    desc "Restart Application"
    task :restart, :roles => :app, :except => { :no_release => true } do
        run "touch #{current_path}/tmp/restart.txt"
    end
end

namespace :deploy do
    [:start, :stop, :restart].each do |t|
        desc "#{t} task is a no-op with mod_rails"
        task t, :roles => :app do ; end
    end
end

after :deploy, "passenger:restart"

set :stages, ["production"]
set :default_stage, "production"

set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
