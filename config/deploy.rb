# config valid only for current version of Capistrano
lock '3.8.1'

set :application, 'team_registration'
set :repo_url, 'git@bitbucket.org:petrpalata/team_registration.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/kwertan/team_registration'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/aws.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
# user which will execute commands

set :user, "kwertan"
set :stages, ["production"]
set :default_stage, "production"

# allow ssh agent forwarding to local host
set :ssh_options, {
    forward_agent: true
}

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :passenger do
  desc "Restart Application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, current_path.join("tmp/restart.txt")
    end
  end
end

after :deploy, "passenger:restart"
