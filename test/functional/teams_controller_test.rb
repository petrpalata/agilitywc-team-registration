require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

  setup do
    @team = handlers(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:handlers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team" do
    assert_difference('Handler.count') do
      post :create, :handler => { }
    end

    assert_redirected_to handlers_path(assigns(:handler))
  end

  test "should show team" do
    get :show, :id => @team
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @team
    assert_response :success
  end

  test "should update team" do
    put :update, :id => @team, :team => {  }
    assert_redirected_to handlers_path(assigns(:handler))
  end

  test "should destroy team" do
    assert_difference('Handler.count', -1) do
      delete :destroy, :id => @team
    end

    assert_redirected_to handlers_path
  end
end
