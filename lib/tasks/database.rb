namespace :db do
  namespace :migrate do
    desc "Perform migration up to latest migration available"
    task :up => :app do
      Sequel.extension(:migration)
      Sequel::Migrator.run(Sequel::Model.db, "db/migrate")
      puts "<= db:migrate:up executed"
    end
    desc "Perform migration down (erase all data)"
    task :down => :app do
      Sequel.extension(:migration)
      Sequel::Migrator.run(Sequel::Model.db, "db/migrate", target: 0)
      puts "<= db:migrate:down executed"
    end
  end

  desc "Perform migration up to latest migration available"
  task :migrate => "db:migrate:up"
  end