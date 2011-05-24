# coding: utf-8
namespace :deploy do
  PRODUCTION_APP = 'perseus'
  STAGING_APP = 'perseus-dev'

  def run(*cmd)
    system(*cmd)
    raise "Command #{cmd.inspect} failed!" unless $?.success?
  end

  def confirm(message)
    print "\n#{message}\nAre you sure? [Yn] "
    raise 'Aborted' unless STDIN.gets.chomp == 'Y'
  end

  desc "Deploy to staging (heroku application name: #{STAGING_APP})"
  task :staging do
    confirm('This will deploy your current HEAD to staging.')
    run "git push git@heroku.com:#{STAGING_APP}.git HEAD:master -f"
    run "heroku rake db:migrate --app #{STAGING_APP}"
  end

  desc "Deploy to production (heroku application name: #{PRODUCTION_APP})"
  task :production do
    iso_date = Time.now.strftime('%Y-%m-%dT%H%M%S')

    confirm('This will deploy the production branch to production.')

    puts "Backing up…"
    Dir.chdir(File.join(File.dirname(__FILE__), *%w[.. .. backups])) do
      run "heroku bundles:destroy deploybackup --app #{PRODUCTION_APP}" if `heroku bundles --app #{PRODUCTION_APP}` =~ /deploybackup/
      run "heroku bundles:capture deploybackup --app #{PRODUCTION_APP}"
      puts " … waiting for Heroku"
      while sleep(5) && `heroku bundles --app #{PRODUCTION_APP}` !~ /complete/
        puts " … still waiting"
      end
      puts " … downloading backup"
      run "heroku bundles:download deploybackup --app #{PRODUCTION_APP}"
      run "mv #{PRODUCTION_APP}{,_#{iso_date}}.tar.gz"
    end

    tag_name = "heroku-#{iso_date}"
    puts "Tagging as #{tag_name}…"
    run "git tag #{tag_name} production"

    puts "Pushing…"
    run "git push origin #{tag_name}"
    run "git push git@heroku.com:#{PRODUCTION_APP}.git #{tag_name}:master"

    puts "Migrating…"
    run "heroku rake db:migrate --app #{PRODUCTION_APP}"
  end

end

