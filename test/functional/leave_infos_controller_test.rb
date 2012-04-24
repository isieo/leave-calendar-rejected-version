require 'test_helper'

class LeaveInfosControllerTest < ActionController::TestCase
  setup do
    @leave_info = leave_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leave_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create leave_info" do
    assert_difference('LeaveInfo.count') do
      post :create, leave_info: @leave_info.attributes
    end

    assert_redirected_to leave_info_path(assigns(:leave_info))
  end

  test "should show leave_info" do
    get :show, id: @leave_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @leave_info
    assert_response :success
  end

  test "should update leave_info" do
    put :update, id: @leave_info, leave_info: @leave_info.attributes
    assert_redirected_to leave_info_path(assigns(:leave_info))
  end

  test "should destroy leave_info" do
    assert_difference('LeaveInfo.count', -1) do
      delete :destroy, id: @leave_info
    end

    assert_redirected_to leave_infos_path
  end
end
