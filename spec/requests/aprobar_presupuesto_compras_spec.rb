require 'spec_helper'

feature 'Aprobacion de presupuesto de requerimiento.',
  %Q{Con el fin de poder controlar las compras generadas
  por los requerimientos. Se necesita que todos los usuario
  encargados del sector compras aprueben cada unos de los
  requerimientos} do

  def login_and_visit_requerimiento(user)
    login_as(user)
    visit requerimiento_path(@requerimiento)
  end

  let(:responsable) { responsables.first }
  let(:responsables) { [create(:usuario), create(:usuario)] }

  background do
    @requerimiento = build(:requerimiento)
    @requerimiento.estado = Estado::PENDIENTE_APROBACION_COMPRAS
    @requerimiento.save!
    @requerimiento.presupuestos << create(:presupuesto)
    @requerimiento.presupuestos << create(:presupuesto)
    Sector.stub_chain(:compras, :responsables).and_return(responsables)
  end

  context 'cuando un encargado de compras ingresa a un requerimiento pendiente de aprobacion por compras' do

    context 'y el presupuesto no fue pre aprobado por otro encargado' do
      before do
        login_and_visit_requerimiento(responsable)
      end

      it 'entonces debe ver el listado de presupestos' do
        current_path.should == requerimiento_path(@requerimiento)
        page.should have_selector('table.presupuestos')
      end
      it 'puede aprobar un presupuesto de la lista' do
        page.should have_selector('table.presupuestos tr:last td.actions a.approve')
      end
      it 'puede rechazar los presupuestos' do
        page.should have_selector('#rqm_actions > a.reject')
      end

    end

    context 'si el presupuesto ya fue pre aprobado y aun faltan aprobaciones' do
      before do
        @requerimiento.aprobar_presupuesto_por_compras!(@requerimiento.presupuestos.first, responsables.last)
        login_and_visit_requerimiento(responsable)
      end

      it 'entonces no puede seleccionar entre varios presupuestos' do
        #page.should_not have_selector('table.presupuestos') # correcto - original - 2015 8 4
        page.should have_selector('table.presupuestos')
      end
      it 'debe ver los detalles del presupuesto pre-aprobado' do
        page.should have_content('Presupuesto seleccionado')
      end
      it 'puede aprobar dicho presupuesto' do
        page.should have_link('Aprobar presupuesto')
      end
      it 'puede rechazar los presupuestos' do
        page.should have_selector('#rqm_actions > a.reject')
      end
    end

  end

  context 'cuando un encargado de compras aprueba un presupuesto' do
    before do
      login_and_visit_requerimiento(responsable)
      find('table.presupuestos tr:last td.actions a.approve').click
    end

    it 'no puede rechazar otros presupuestos' do
      page.should_not have_selector('#rqm_actions > a.reject')
    end
    it 'no puede aprobar otros presupuestos' do
      page.should_not have_selector('table.presupuestos tr:last td.actions a.approve')
      page.should_not have_link('Aprobar presupuesto')
    end

    context 'y ya cuenta con todas las aprobaciones' do
      let(:responsables) { [create(:usuario)] }

      it "entonces, el requerimiento, debe pasar a 'Aprobado por compras'" do
        Requerimiento.find(@requerimiento.id).estado.should == Estado::APROBADO_X_COMPRAS
      end
    end
    context 'y aun requiere de mas aprobaciones' do
      it 'el requerimiento debe continuar pendiente de aprobacion por compras' do
        Requerimiento.find(@requerimiento.id).estado.should == Estado::PENDIENTE_APROBACION_COMPRAS
      end
    end
  end

end
