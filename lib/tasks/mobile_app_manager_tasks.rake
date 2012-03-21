# desc "Explaining what the task does"
# task :mobile_app_manager do
#   # Task goes here
# end

require 'net/scp'
namespace :mobile_app_manager do
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
end
