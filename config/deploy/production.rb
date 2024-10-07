server '18.189.243.40', user: 'ubuntu', roles: %w{app db web}

set :branch, ENV['BRANCH'] || 'main'
set :deploy_to, '/home/ubuntu/class_ranking'
set :rails_env, 'production'
set :rvm_binary, '/home/ubuntu/.rvm/bin/rvm'
set :deploy_via, :remote_cache

# set :puma_threads,    [4, 16]
# set :puma_workers,    1

append :linked_files, "config/master.key", "config/credentials.yml.enc"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "public/sitemaps","tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
      end
    end
  end

  # task :restart_jobs do
  #   on roles :app do
  #     execute "cd #{current_path} && RAILS_ENV=#{fetch(:rails_env)} #{fetch(:rvm_binary)} #{fetch(:rvm_ruby_version)} do bundle exec bin/delayed_job stop"
  #     execute "cd #{current_path} && RAILS_ENV=#{fetch(:rails_env)} #{fetch(:rvm_binary)} #{fetch(:rvm_ruby_version)} do bundle exec bin/delayed_job start"
  #   end
  # end

  # task :restart_sidekiq do
  #   on roles :app do
  #     execute "sudo service sidekiq-mailers restart"
  #   end
  # end

  task :restart do
    invoke 'unicorn:legacy_restart'
  end

end

after 'deploy:publishing', 'deploy:restart'
# after 'deploy:restart_sidekiq', 'deploy:restart'

# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{ubuntu@3.13.130.216}
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
set :ssh_options, {
  keys: "~/.ssh/stylemyle-staging.cer",
  forward_agent: false,
  auth_methods: %w(publickey)
}


#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
