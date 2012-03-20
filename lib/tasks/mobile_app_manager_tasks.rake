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

  desc "Publishes iOS build to the remote server"
  task :publish_build => :environment, :create_publish_files do
    build_root         = Rails.root.join "mobileapps/"
    configuration_file = build_root.join 'mobileapps.yml'
    build_config       = YAML::load(File.open(configuration_file))

    ios_build_dir = build_root.join build_config['ios']['directory']

    # Dirty way, just iterate over all of the files and pick the ones
    # we want, namely the .ipa and .plist
    ios_build_dir.each_child do |f|
      if f.extname == ".ipa" then
        puts "IPA #{f}"
      end

      if f.extname == ".plist" then
        puts "Plist #{f}"
      end
    end

  end

  desc "Insert a mobile app build record"
  task :insert_app_record => :environment, :publish_build do
    app = MobileAppManager::Mobileapp.new
    app.name     = "UplinkRemote"
    app.version  = "1.1.3"      # this should be from environment
    app.platform = "iOS"        # We know this because of the namespace
    app.install_url = "itms-services://?action=download-manifest&url=public/mobileapps/com.mooveit.uplink.1.2.4.plist" # Needs to be a reference to a plist
    app.relnotes_url = ""
    app.save!
  end

end
