require 'test_helper'

class SectoresControllerTest < ActionController::TestCase
  setup do
    @sector = sectores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sectores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sector" do
    assert_difference('Sector.count') do
      post :create, :sector => @sector.attributes
    end

    assert_redirected_to sector_path(assigns(:sector))
  end

  test "should show sector" do
    get :show, :id => @sector.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sector.to_param
    assert_response :success
  end

  test "should update sector" do
    put :update, :id => @sector.to_param, :sector => @sector.attributes
    assert_redirected_to sector_path(assigns(:sector))
  end

  test "should destroy sector" do
    assert_difference('Sector.count', -1) do
      delete :destroy, :id => @sector.to_param
    end

    assert_redirected_to sectores_path
  end
end
