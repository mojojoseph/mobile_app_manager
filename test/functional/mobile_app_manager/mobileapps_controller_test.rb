require 'test_helper'

module MobileAppManager
  class MobileappsControllerTest < ActionController::TestCase
    setup do
      @mobileapp = mobileapps(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:mobileapps)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create mobileapp" do
      assert_difference('Mobileapp.count') do
        post :create, mobileapp: @mobileapp.attributes
      end
  
      assert_redirected_to mobileapp_path(assigns(:mobileapp))
    end
  
    test "should show mobileapp" do
      get :show, id: @mobileapp
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @mobileapp
      assert_response :success
    end
  
    test "should update mobileapp" do
      put :update, id: @mobileapp, mobileapp: @mobileapp.attributes
      assert_redirected_to mobileapp_path(assigns(:mobileapp))
    end
  
    test "should destroy mobileapp" do
      assert_difference('Mobileapp.count', -1) do
        delete :destroy, id: @mobileapp
      end
  
      assert_redirected_to mobileapps_path
    end
  end
end
