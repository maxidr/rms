require 'test_helper'

class RequerimientosControllerTest < ActionController::TestCase
  setup do
    @requerimiento = requerimientos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requerimientos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requerimiento" do
    assert_difference('Requerimiento.count') do
      post :create, :requerimiento => @requerimiento.attributes
    end

    assert_redirected_to requerimiento_path(assigns(:requerimiento))
  end

  test "should show requerimiento" do
    get :show, :id => @requerimiento.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @requerimiento.to_param
    assert_response :success
  end

  test "should update requerimiento" do
    put :update, :id => @requerimiento.to_param, :requerimiento => @requerimiento.attributes
    assert_redirected_to requerimiento_path(assigns(:requerimiento))
  end

  test "should destroy requerimiento" do
    assert_difference('Requerimiento.count', -1) do
      delete :destroy, :id => @requerimiento.to_param
    end

    assert_redirected_to requerimientos_path
  end
end
