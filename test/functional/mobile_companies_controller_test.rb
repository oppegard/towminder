require 'test_helper'

class MobileCompaniesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mobile_companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mobile_company" do
    assert_difference('MobileCompany.count') do
      post :create, :mobile_company => { }
    end

    assert_redirected_to mobile_company_path(assigns(:mobile_company))
  end

  test "should show mobile_company" do
    get :show, :id => mobile_companies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => mobile_companies(:one).to_param
    assert_response :success
  end

  test "should update mobile_company" do
    put :update, :id => mobile_companies(:one).to_param, :mobile_company => { }
    assert_redirected_to mobile_company_path(assigns(:mobile_company))
  end

  test "should destroy mobile_company" do
    assert_difference('MobileCompany.count', -1) do
      delete :destroy, :id => mobile_companies(:one).to_param
    end

    assert_redirected_to mobile_companies_path
  end
end
