require 'spec_helper'

describe "estados_pagos/edit" do
  before(:each) do
    @estado_pago = assign(:estado_pago, stub_model(EstadoPago,
      :nombre => "MyString"
    ))
  end

  it "renders the edit estado_pago form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", estado_pago_path(@estado_pago), "post" do
      assert_select "input#estado_pago_nombre[name=?]", "estado_pago[nombre]"
    end
  end
end
