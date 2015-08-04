require 'spec_helper'

describe DetalleVerificacionCompras do

  describe '.para_el_presupuesto' do
    context 'cuando el presupuesto tiene un detalleVerficacionCompras' do
      before do
        @presupuesto = Presupuesto.new
        @detalle = DetalleVerificacionCompras.new(:presupuesto => @presupuesto)
        @detalle.id = 10
        DetalleVerificacionCompras.stub(:where) { [@detalle] }
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
        @detalle_para_el_presupuesto.aprobado.should be_falsey
      end

      it "el detalleVerficacioCompras debe estar relacionado con el presupuesto" do
        @detalle_para_el_presupuesto.presupuesto.should == @presupuesto
      end
    end
  end

  describe '#aprobar_por' do
    before do
      #@presupuesto = Presupuesto.new
      @presupuesto = create(:presupuesto)
      @detalle = DetalleVerificacionCompras.new(:presupuesto => @presupuesto)
      #@autorizante = Usuario.new(:nombre => 'Julian', :apellido => 'Alvarez')
      @autorizante = create(:usuario)
      @now = DateTime.now
      DateTime.stub(:now) { @now }
    end
    it 'debe crear una verificacionEncargadoCompras para el presupuesto del DetalleVerificacionCompras' do
      @detalle.aprobar_por(@autorizante)
      @detalle.presupuesto.verificaciones.should_not be_empty
      #@detalle.verificaciones.should_not be_empty
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

    let(:verificaciones_responsables_de_compras) do
      responsables_de_compras.map do |responsable|
        verificacion = double('detalle_verificacion_compras')
        verificacion.stub(:verificador_id) { responsable.id }
        verificacion
      end
    end

    before do
      @detalle = DetalleVerificacionCompras.new
      verificaciones = double(Array)
      verificaciones.stub(:count).and_return(verificaciones_responsables_de_compras.count)
      verificaciones.stub(:select).and_return(verificaciones_responsables_de_compras)
      @detalle.stub_chain(:presupuesto, :verificaciones).and_return(verificaciones)
    end
    context 'si todos los responsables de compras autorizaron el presupuesto' do
      it 'debe retornar true' do
        @detalle.aprobacion_finalizada?(responsables_de_compras).should be_truthy
      end
    end

    context 'si algunos responsables de compras no autorizaron el presupuesto' do

      before do
        algunas_verificaciones = verificaciones_responsables_de_compras.first(2)
        verificaciones = double(Array)
        verificaciones.stub(:select).and_return(algunas_verificaciones)
        verificaciones.stub(:count).and_return(algunas_verificaciones.size)
        @detalle.stub_chain(:presupuesto, :verificaciones).and_return(verificaciones)
      end

      it 'debe retornar false' do
        @detalle.aprobacion_finalizada?(responsables_de_compras).should be_falsey
      end
    end

    context 'si uno de los autorizantes ya no es responsable y todos lo demas ya aprobaron el presupuesto' do
      it 'debe retornar true' do
        responsables_actuales = responsables_de_compras.first(2)
        @detalle.aprobacion_finalizada?(responsables_actuales).should be_truthy
      end
    end

  end

end
