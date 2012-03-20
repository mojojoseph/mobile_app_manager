#require 'mobile_app_manager'

Capistrano::Configuration.instance.load do

  namespace :mobile_app_manager do
    desc "Publish an IPA to a remote deployment server"
    task :publish do
      puts "Uploading IPA to #{deploy_to}"
      upload("ipa", #{deploy_to}/public/mobileapps")
    end
  end

end
