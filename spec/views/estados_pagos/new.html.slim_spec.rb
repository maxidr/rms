require 'spec_helper'

describe "estados_pagos/new" do
  before(:each) do
    assign(:estado_pago, stub_model(EstadoPago,
      :nombre => "MyString"
    ).as_new_record)
  end

  it "renders new estado_pago form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", estados_pagos_path, "post" do
      assert_select "input#estado_pago_nombre[name=?]", "estado_pago[nombre]"
    end
  end
end
