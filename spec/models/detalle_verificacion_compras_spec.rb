require 'spec_helper'

describe DetalleVerificacionCompras do

  describe '.para_el_presupuesto' do
    context 'cuando el presupuesto tiene un detalleVerficacionCompras' do 
      before do
        @presupuesto = Presupuesto.new
        @detalle = DetalleVerificacionCompras.new(:presupuesto => @presupuesto)
        @detalle.id = 10
        DetalleVerificacionCompras.stub!(:where) { [@detalle] }
      end

      it "debe retornar dicho detalle" do
        DetalleVerificacionCompras.para_el_presupuesto(@presupuesto).should == @detalle
      end

    end
    context "cuando el presupuesto no posee un detalleVerficacionCompras" do
      before do
        @presupuesto = Presupuesto.new
        @presupuesto.id = 4
        @detalle_para_el_presupuesto = DetalleVerificacionCompras.para_el_presupuesto(@presupuesto)
      end

      it "debe retornar un nuevo detalleVerficacioCompras" do
        @detalle_para_el_presupuesto.id.should be_nil
      end

      it "el detalleVerficacioCompras no debe estar aprobado" do
        @detalle_para_el_presupuesto.aprobado.should be_false
      end

      it "el detalleVerficacioCompras debe estar relacionado con el presupuesto" do
        @detalle_para_el_presupuesto.presupuesto.should == @presupuesto
      end
    end
  end

  describe '#aprobar_por' do
    before do
      @presupuesto = Presupuesto.new
      @detalle = DetalleVerificacionCompras.new(:presupuesto => @presupuesto)
      @autorizante = Usuario.new(:nombre => 'Julian', :apellido => 'Alvarez') 
      @now = DateTime.now
      DateTime.stub!(:now) { @now }
    end
    it 'debe crear una verificacionEncargadoCompras al DetalleVerificacionCompras' do
      @detalle.verificaciones
        .should_receive(:create)
        .with(hash_including(:verificador => @autorizante, :presupuesto => @detalle.presupuesto, :fecha_aprobacion => @now))
      @detalle.aprobar_por(@autorizante)
    end
  end

  describe '#aprobacion_finalizada?' do
    let(:responsables_de_compras) do
      (1..3).map do |id| 
        user = double('user')
        user.stub(:id) { id }
        user
      end
    end

    before do
      @detalle = DetalleVerificacionCompras.new
      @detalle.verificaciones = []
      @detalle.verificaciones.stub!(:count).and_return(responsables_de_compras.count)
      @detalle.verificaciones.stub!(:select).and_return(responsables_de_compras)
      #@detalle.stub_chain(:verificaciones, :select).and_return(responsables_de_compras)
    end
    context 'si todos los responsables de compras autorizaron el presupuesto' do
      it 'debe retornar true' do
        @detalle.aprobacion_finalizada?(responsables_de_compras).should be_true
      end
    end

    context 'si algunos responsables de compras no autorizaron el presupuesto' do
      it 'debe retornar false' do
        algunos_responsables = responsables_de_compras.first(2)
        @detalle.verificaciones.stub!(:select).and_return(algunos_responsables)
        @detalle.verificaciones.stub!(:count).and_return(algunos_responsables.size)
        @detalle.aprobacion_finalizada?(responsables_de_compras).should be_false
      end
    end

    context 'si uno de los autorizantes ya no es responsable y todos lo demas ya aprobaron el presupuesto' do
      it 'debe retornar true' do
        responsables_actuales = responsables_de_compras.first(2)
        @detalle.aprobacion_finalizada?(responsables_actuales).should be_true
      end
    end

  end

end
