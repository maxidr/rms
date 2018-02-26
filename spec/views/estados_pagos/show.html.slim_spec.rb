require 'spec_helper'

describe "estados_pagos/show" do
  before(:each) do
    @estado_pago = assign(:estado_pago, stub_model(EstadoPago,
      :nombre => "Nombre"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
  end
end
