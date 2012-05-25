require 'spec_helper'

describe Presupuesto do
  let(:presupuesto) { build(:presupuesto) }
  let(:verificador) { build(:usuario) }

  it { should respond_to(:seleccionado) }
  it { should respond_to(:aprobado) }

  context 'con los parametros correctos' do
    it 'debe ser valido' do  
      presupuesto.should be_valid 
    end
  end

  describe '#seleccionado. Un presupuesto es seleccionado cuando al menos un usuario verificador lo selecciona' do    
    context 'cuando se agrega una verificacion al presupuesto' do
      before do
        @presupuesto = presupuesto
        v = @presupuesto.verificaciones.build(:verificador => verificador, :fecha_aprobacion => DateTime.now)
        v.save!
      end
      it 'debe quedar seleccionado' do
        @presupuesto.seleccionado.should be_true 
      end
    end
  end
end
