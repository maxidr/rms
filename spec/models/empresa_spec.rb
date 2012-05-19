require 'spec_helper'

describe Empresa do
  it { should validate_presence_of :nombre }

  it_behaves_like 'deshabilitable'

  it "debe ser valida con todos los atributos correctos" do
    build(:empresa).should be_valid
  end
  
end
