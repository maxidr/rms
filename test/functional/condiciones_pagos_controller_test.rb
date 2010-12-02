require 'test_helper'

class CondicionesPagosControllerTest < ActionController::TestCase
  setup do
    @condicion_pago = condiciones_pagos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:condiciones_pagos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create condicion_pago" do
    assert_difference('CondicionPago.count') do
      post :create, :condicion_pago => @condicion_pago.attributes
    end

    assert_redirected_to condicion_pago_path(assigns(:condicion_pago))
  end

  test "should show condicion_pago" do
    get :show, :id => @condicion_pago.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @condicion_pago.to_param
    assert_response :success
  end

  test "should update condicion_pago" do
    put :update, :id => @condicion_pago.to_param, :condicion_pago => @condicion_pago.attributes
    assert_redirected_to condicion_pago_path(assigns(:condicion_pago))
  end

  test "should destroy condicion_pago" do
    assert_difference('CondicionPago.count', -1) do
      delete :destroy, :id => @condicion_pago.to_param
    end

    assert_redirected_to condiciones_pagos_path
  end
end
