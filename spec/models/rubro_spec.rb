require 'spec_helper'

describe Rubro do
  it_behaves_like 'deshabilitable'
  it { should validate_presence_of :nombre }

  it 'debe ser valido con los atributos necesarios' do
    build(:rubro).should be_valid
  end
end
