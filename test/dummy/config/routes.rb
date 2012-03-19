Rails.application.routes.draw do

  mount MobileAppManager::Engine => "/mobile_app_manager"
end
