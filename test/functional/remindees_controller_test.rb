require 'test_helper'

class RemindeesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:remindees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create remindee" do
    assert_difference('Remindee.count') do
      post :create, :remindee => { }
    end

    assert_redirected_to remindee_path(assigns(:remindee))
  end

  test "should show remindee" do
    get :show, :id => remindees(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => remindees(:one).to_param
    assert_response :success
  end

  test "should update remindee" do
    put :update, :id => remindees(:one).to_param, :remindee => { }
    assert_redirected_to remindee_path(assigns(:remindee))
  end

  test "should destroy remindee" do
    assert_difference('Remindee.count', -1) do
      delete :destroy, :id => remindees(:one).to_param
    end

    assert_redirected_to remindees_path
  end
end
