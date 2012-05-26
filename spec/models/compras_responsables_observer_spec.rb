require 'spec_helper'

describe ComprasResponsablesObserver do
  
  let(:requerimiento) do
    rqm = create(:requerimiento)
    rqm.estado = Estado::PENDIENTE_APROBACION_COMPRAS
    rqm.presupuestos << create(:presupuesto)
    rqm.save!
    rqm
  end

  let(:otro_requerimiento_pendiente) do
    rqm = create(:requerimiento)
    rqm.estado = Estado::PENDIENTE_APROBACION_COMPRAS
    rqm.presupuestos << create(:presupuesto)
    rqm.save!
    rqm
  end

  let(:otro_requerimiento) do
    requerimiento = create(:requerimiento)
    requerimiento.estado = Estado::PENDIENTE_APROBACION_SECTOR
    requerimiento
  end

  let(:responsables_compras) do
    [ create(:usuario), create(:usuario), create(:usuario) ]
  end
  
  let(:compras) do
    create(:sector, :nombre => 'Compras', :responsables => responsables_compras)
  end

  context 'cuando un usuario es eliminado de los responsables del sector compras' do
    before do
      Sector.stub(:compras).and_return(compras)
      requerimiento
      otro_requerimiento_pendiente
      otro_requerimiento
      presupuesto = requerimiento.presupuestos.first
      requerimiento.aprobar_presupuesto_por_compras!(presupuesto, responsables_compras[0])
      requerimiento.aprobar_presupuesto_por_compras!(presupuesto, responsables_compras[1])

      presupuesto = otro_requerimiento_pendiente.presupuestos.first
      otro_requerimiento_pendiente.aprobar_presupuesto_por_compras!(presupuesto, responsables_compras.first)

      compras.responsables.delete(responsables_compras.last)
    end

    it 'los requerimientos que no estan pendientes de aprobacion por compras no se aprueban' do
      rqm = Requerimiento.find(otro_requerimiento.id)
      rqm.estado.should_not == Estado::APROBADO_X_COMPRAS
    end

    it %q(los requerimientos que estan pendientes de aprobacion por compras pero que 
          les falta la validacion de mas de un encargado no se aprueban) do
      rqm3 = Requerimiento.find(otro_requerimiento_pendiente.id)
      rqm3.estado.should_not == Estado::APROBADO_X_COMPRAS
    end

    it %q(se deben aprobar todos los requerimientos que esten en 
          estado 'pendiente de aprobacion por compras' y que solo faltaba 
          la validacion de dicho usuario) do
      rqm = Requerimiento.find(requerimiento.id) 
      rqm.estado.should == Estado::APROBADO_X_COMPRAS
    end
  end
end
