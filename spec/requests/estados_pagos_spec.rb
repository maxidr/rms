require 'spec_helper'

describe "EstadosPagos" do
  describe "GET /estados_pagos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get estados_pagos_path
      response.status.should be(200)
    end
  end
end
