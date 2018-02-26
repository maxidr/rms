require "spec_helper"

describe EstadosPagosController do
  describe "routing" do

    it "routes to #index" do
      get("/estados_pagos").should route_to("estados_pagos#index")
    end

    it "routes to #new" do
      get("/estados_pagos/new").should route_to("estados_pagos#new")
    end

    it "routes to #show" do
      get("/estados_pagos/1").should route_to("estados_pagos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/estados_pagos/1/edit").should route_to("estados_pagos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/estados_pagos").should route_to("estados_pagos#create")
    end

    it "routes to #update" do
      put("/estados_pagos/1").should route_to("estados_pagos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/estados_pagos/1").should route_to("estados_pagos#destroy", :id => "1")
    end

  end
end
