require 'bundler/capistrano'
require 'capistrano-rbenv'

set :application, "team_registration"
#set :repository, "ssh://petr@kacr.info:10522/home/git/repositories/team_registration.git"
set :repository, 'git@bitbucket.org:petrpalata/team_registration.git'
set :branch, "master"
#set :deploy_via, :remote_cache
set :scm, :git
set :bundle_flags,    "--deployment"
set :bundle_without,  []
set :use_sudo, false

set :rbenv_ruby_version, "1.9.3-p551"

load 'deploy/assets'

default_run_options[:pty] = true

set :deploy_to, '/home/kwertan/team_registration'

set :ssh_options, { :forward_agent => true }

role :assets, "agility2017.cz"
role :app, "agility2017.cz"
role :web, "agility2017.cz"
role :db,  "agility2017.cz", :primary => true

set :user, "kwertan"

set :stages, ["production"]
set :default_stage, "production"

set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')

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
