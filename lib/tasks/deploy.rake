# coding: utf-8

require 'version'

namespace :deploy do

  ENVIRONMENTS = {
    staging: 'staging',
    production: 'production'
  }

  def run(*cmd)
    system(*cmd)
    raise "Command #{cmd.inspect} failed!" unless $?.success?
  end

  def confirm(message)
    print "\n#{message}\nAre you sure? [yN] "
    raise 'Aborted' unless STDIN.gets.chomp.downcase == 'y'
  end

  def last_version
    tags = `git tag`
    tags.split(/\n/).sort.last
  end

  def version_exist?(tag)
    tags = `git tag`
    tags.split(/\n/).include? tag
  end

  def compile_stylesheets_for_production
    print "compiling stylesheets...\n"
    run "bundle exec compass compile -e production --force"
  end

  desc 'Show the environments configuration for deployment'
  task :show_environments do
    ENVIRONMENTS.keys.each do |env|
      print "#{env.to_s.ljust(20)} -> git remote name: #{ENVIRONMENTS[env]}\n"
    end
  end

  task :staging do
    #confirm('This will deploy your current HEAD to heroku dev')
    #compile_stylesheets_for_production
    # create a new tag
    print "Incrementing version...\n"
    Rake::Task['version:bump'].invoke
    last_version = Version.current
    print "Versioned to #{last_version}\n"
    print "Tagging the new version\n"
    run "git tag #{last_version}"
    # deploy to heroku the last tag
    #run "git push #{env} +#{last_version}~{}:master"
    print "Deploying version #{last_version} to #{ENVIRONMENTS[:staging]}...\n"
    run "git push #{ENVIRONMENTS[:staging]} #{last_version}^{}:master"
    print "Push project to origin...\n"
    run "git push origin master"
  end


  [:production].each do |env|
    desc "Deploy to #{env} the last tag, or the tag especified vi tag parameter (ex.: tag=0.1.0)"
    task env do
      from_tag = ENV['tag']
      unless from_tag.nil?
        version = from_tag
        raise "The version #{from_tag} not exist" unless version_exist? version
      else
        version = last_version
      end

      confirm("This will deploy the version #{version} to heroku #{env} (remote: #{ENVIRONMENTS[env]})")
      run "git push #{ENVIRONMENTS[env]} #{version}^{}:master"
    end
  end


  #task :staging do
  #  from_tag = ENV['tag']
  #  unless from_tag.nil?
  #    version = from_tag
  #    raise "The version #{from_tag} not exist" unless version_exist? version
  #  else
  #    version = last_version
  #  end

  #  confirm("This will deploy the version #{version} to heroku stage")
  #  print "git push #{ENVIRONMENTS[:staging]} +#{version}~{}:master"
  #end

  #task :production do
  #  from_tag = ENV['tag']

  #end

  #desc "Deploy to staging (heroku application name: #{STAGING_APP})"
  #task :staging do
  #  confirm('This will deploy your current HEAD to staging.')
  #  run "git push git@heroku.com:#{STAGING_APP}.git HEAD:master -f"
  #  run "heroku rake db:migrate --app #{STAGING_APP}"
  #end

  #desc "Deploy to production (heroku application name: #{PRODUCTION_APP})"
  #task :production do
  #  iso_date = Time.now.strftime('%Y-%m-%dT%H%M%S')

  #  confirm('This will deploy the production branch to production.')

#    puts "Backing up…"
#    Dir.chdir(File.join(File.dirname(__FILE__), *%w[.. .. backups])) do
#      run "heroku bundles:destroy deploybackup --app #{PRODUCTION_APP}" if `heroku bundles --app #{PRODUCTION_APP}` =~ /deploybackup/
#      run "heroku bundles:capture deploybackup --app #{PRODUCTION_APP}"
#      puts " … waiting for Heroku"
#      while sleep(5) && `heroku bundles --app #{PRODUCTION_APP}` !~ /complete/
#        puts " … still waiting"
#      end
#      puts " … downloading backup"
#      run "heroku bundles:download deploybackup --app #{PRODUCTION_APP}"
#      run "mv #{PRODUCTION_APP}{,_#{iso_date}}.tar.gz"
#    end

    #tag_name = "heroku-#{iso_date}"
    #puts "Tagging as #{tag_name}..."
    #run "git tag #{tag_name}"

    #puts "Pushing..."
    #run "git push origin #{tag_name}"
    #run "git push git@heroku.com:#{PRODUCTION_APP}.git #{tag_name}:master"

    #puts "Migrating..."
    #run "heroku rake db:migrate --app #{PRODUCTION_APP}"
  #end

end

