$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mobile_app_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mobile_app_manager"
  s.version     = MobileAppManager::VERSION
  s.authors     = ["Joseph Bell"]
  s.email       = ["jbell@numerex.com"]
  s.homepage    = "http://numerex.com"
  s.summary     = "Summary of MobileAppManager"
  s.description = "Description of MobileAppManager"

  s.files = Dir["{app,config,db,lib,recipes}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
