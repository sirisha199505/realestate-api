begin; require 'dotenv'; Dotenv.load; rescue LoadError; end

namespace :db do
  desc "Run migrations (optionally to a specific version)"
  task :migrate, [:version] do |_t, args|
    require 'sequel'
    require 'sequel/core'
    Sequel.extension :migration

    db_url = ENV['DB_URL'] || raise('DB_URL environment variable is not set.')
    version = args[:version]&.to_i

    puts "Connecting to database..."
    Sequel.connect(db_url) do |db|
      db.extension :pg_enum
      Sequel::Migrator.run(db, 'src/migrations', target: version)
    end
    puts "Migrations complete!"
  end

  desc "Roll back all migrations"
  task :rollback do
    Rake::Task['db:migrate'].invoke(0)
  end
end


require 'optparse'

namespace :create do
  desc "Creates Model"
  task :models do
    models = []
    OptionParser.new do |opts|
      opts.banner = "Usage: rake create:models [options]"
      opts.on("-n", "--names ARG", String) { |str| models += str.split(',') }
    end.parse!
    puts models
  end
end
