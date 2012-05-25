require 'spec_helper'

describe Presupuesto do
  let(:presupuesto) { build(:presupuesto) }

  it { should respond_to(:seleccionado) }
  it { should respond_to(:aprobado) }

  context 'con los parametros correctos' do
    it 'debe ser valido' do  
      presupuesto.should be_valid 
    end
  end

end
