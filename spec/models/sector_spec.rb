require 'spec_helper'

describe Sector do
  it { should validate_presence_of :nombre }
  it { should validate_presence_of :responsables }

  it_behaves_like 'deshabilitable'

  it 'debe ser valido si se cargan todos los atributos necesarios' do
    build(:sector).should be_valid
  end

end
