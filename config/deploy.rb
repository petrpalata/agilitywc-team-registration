require 'bundler/capistrano'
require 'rvm/capistrano'
set :application, "team_registration"
set :repository, "ssh://petr@kacr.info:10522/home/git/repositories/team_registration.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :scm, :git
set :rvm_ruby_string, 'ree-1.8.7-2011.12'
set :rvm_type, :system
set :bundle_flags,    "--deployment"
set :bundle_without,  []
set :use_sudo, false

load 'deploy/assets'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/webapps/#{application}"

set :ssh_options, { :port => 10722, :forward_agent => true }

role :assets, "kacr.info"
role :app, "kacr.info"
role :web, "kacr.info"
role :db,  "kacr.info", :primary => true

set :user, "petr"

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
