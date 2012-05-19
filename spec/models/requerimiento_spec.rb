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
      @requerimiento = Requerimiento.new
    end
    context 'cuando el presupuesto es aprobado por el autorizante que faltaba' do
      it 'debe quedar aprobado'
      it 'debe quedar asociado con el detalleVerificacionCompras con la aprobacion del autorizante'
    end
  end
end
