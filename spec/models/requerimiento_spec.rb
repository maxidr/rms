require 'spec_helper'

describe Requerimiento do

  it { should validate_presence_of :empresa }
  it { should validate_presence_of :sector }
  it { should validate_presence_of :rubro }
  it { should validate_presence_of :solicitante }
  
  describe '#consumo' do
    it "debe ser un valor entre: #{Requerimiento::FRECUENCIAS_CONSUMO.join(", ")}" do
      requerimiento = build(:requerimiento, :consumo => Requerimiento::FRECUENCIAS_CONSUMO.first)
      requerimiento.should be_valid
      requerimiento.consumo = 'blah!'
      requerimiento.should_not be_valid
    end
  end

  it 'debe ser valido con los atributos necesarios' do
    build(:requerimiento).should be_valid
  end

  describe '#aprobar_presupuesto_por_compras!' do
    before do
      @requerimiento = build(:requerimiento)
      @requerimiento.estado = Estado::PENDIENTE_APROBACION_COMPRAS  
      @requerimiento.save
      
      @presupuesto = build(:presupuesto)
      @presupuesto.requerimiento = @requerimiento
      @presupuesto.save

      @autorizante = create(:usuario)
      puts "autorizante id: #{@autorizante.id}"
    end
    context 'cuando el presupuesto es aprobado por el autorizante que faltaba' do
      before do
        Sector.stub_chain(:compras, :responsables).and_return([@autorizante])
        @requerimiento.aprobar_presupuesto_por_compras!(@presupuesto, @autorizante)
      end

      it 'debe quedar en estado aprobado por compras' do
        @requerimiento.estado.should == Estado::APROBADO_X_COMPRAS        
      end
      it 'el presupuesto debe quedar aprobado' do
        @requerimiento.presupuestos.aprobado.should_not be_nil
      end

      it 'debe quedar asociado con el detalleVerificacionCompras con la aprobacion del autorizante' do
        presupuesto_aprobado = @requerimiento.presupuestos.aprobado
        presupuesto_aprobado.verificaciones.should_not be_empty
        #presupuesto_aprobado.aprobado
      end
    end
  end
end
