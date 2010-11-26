require 'test_helper'

class RubrosControllerTest < ActionController::TestCase
  setup do
    @rubro = rubros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rubros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rubro" do
    assert_difference('Rubro.count') do
      post :create, :rubro => @rubro.attributes
    end

    assert_redirected_to rubro_path(assigns(:rubro))
  end

  test "should show rubro" do
    get :show, :id => @rubro.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @rubro.to_param
    assert_response :success
  end

  test "should update rubro" do
    put :update, :id => @rubro.to_param, :rubro => @rubro.attributes
    assert_redirected_to rubro_path(assigns(:rubro))
  end

  test "should destroy rubro" do
    assert_difference('Rubro.count', -1) do
      delete :destroy, :id => @rubro.to_param
    end

    assert_redirected_to rubros_path
  end
end
