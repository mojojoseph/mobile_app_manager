# desc "Explaining what the task does"
# task :mobile_app_manager do
#   # Task goes here
# end

require 'net/scp'
namespace :mobile_app_manager do
  desc "Push IPA to remote server"
  task :push_ipa do
    REMOTE_DIR="/home/ec2-user"
    Net::SCP.start("iachieved.it", "ec2-user") do |scp|
      scp.upload! "foo.txt", REMOTE_DIR
    end
  end

  desc "Records an IPA on the remote server"
  task :record_ipa do
    run("cd #{deploy_to}/current && /usr/bin/env rake #{ENV['task']} RAILS_ENV=#{rails_env}")
  end
  
  desc "Push APK to remote server"
  task :push_apk do
  end
end

namespace :ios do
  desc "Build iOS"
  task :build do
    #
    # 
    #
    build_script = Rails.root.join "mobileapps/iOSLauncher/build.xml"
    puts   "Building with #{build_script}"
    system "ant -f #{build_script} build"
  end

  task :package do
    build_script = Rails.root.join "mobileapps/iOSLauncher/build.xml"
    puts   "Building with #{build_script}"
    system "ant -f #{build_script} package"
  end

  task :create_publish_files do
    build_script = Rails.root.join "mobileapps/iOSLauncher/build.xml"
    puts   "Publish with #{build_script}"
    system "ant -f #{build_script} publish"
  end

  task :insert_record => :environment do
    puts Mobileapp.all.inspect
  end

end
