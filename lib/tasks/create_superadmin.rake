namespace :db do
    desc "Creates superadmin account"
    task :create_superadmin => [:production, :development] do
        SuperAdmin.create(
            :email => 'petr.palata@gmail.com',
            :password => 'obon5usoagility',
            :password_confirmation => 'obon5usoagility'
        ).save
    end
end
