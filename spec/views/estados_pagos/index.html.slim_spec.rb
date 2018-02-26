require 'spec_helper'

describe "estados_pagos/index" do
  before(:each) do
    assign(:estados_pagos, [
      stub_model(EstadoPago,
        :nombre => "Nombre"
      ),
      stub_model(EstadoPago,
        :nombre => "Nombre"
      )
    ])
  end

  it "renders a list of estados_pagos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
  end
end
