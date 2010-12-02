require 'test_helper'

class PresupuestosControllerTest < ActionController::TestCase
  setup do
    @presupuesto = presupuestos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:presupuestos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create presupuesto" do
    assert_difference('Presupuesto.count') do
      post :create, :presupuesto => @presupuesto.attributes
    end

    assert_redirected_to presupuesto_path(assigns(:presupuesto))
  end

  test "should show presupuesto" do
    get :show, :id => @presupuesto.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @presupuesto.to_param
    assert_response :success
  end

  test "should update presupuesto" do
    put :update, :id => @presupuesto.to_param, :presupuesto => @presupuesto.attributes
    assert_redirected_to presupuesto_path(assigns(:presupuesto))
  end

  test "should destroy presupuesto" do
    assert_difference('Presupuesto.count', -1) do
      delete :destroy, :id => @presupuesto.to_param
    end

    assert_redirected_to presupuestos_path
  end
end
