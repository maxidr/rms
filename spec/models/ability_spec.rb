require 'spec_helper'

describe Ability do
  context 'para un requerimiento pendiente de aprobacion por el sector' do

    let(:usuario){ create(:usuario) }
    let(:sector) { build(:sector) }

    before do
      Sector.stub(:compras) { build(:sector) }
      sector.stub_chain(:responsables, :exists?) { true }
      @rqm = build(:requerimiento, :solicitante => usuario, :sector => sector, :estado => Estado::PENDIENTE_APROBACION_SECTOR)
      @ability = Ability.new(usuario)
    end

    it 'puede ser aprobado por un encargado del sector, incluso si es el creador del requerimiento' do
      @ability.can?(:aprobar_por_sector, @rqm).should be_truthy
    end

    it 'no puede ser aprobado por un usuario que no es encargado del sector' do
      sector.stub_chain(:responsables, :exists?) { false }
      @rqm.sector = sector
      @ability.can?(:aprobar_por_sector, @rqm).should be_falsey
    end
  end

  context '#can? :add_material, rqm' do
    before do
      Sector.stub(:compras) { build(:sector) }
      @requerimiento = build(:requerimiento, :sector => sector, :solicitante => solicitante)
      @requerimiento.estado = estado
      @ability = Ability.new(usuario)
    end
    context 'si el usuario que desea hacerlo es el solicitante' do
      let(:usuario) { build(:usuario) }
      let(:solicitante) { usuario }

      context 'y el estado del requerimiento es iniciado' do
        let(:sector) { build(:sector) }
        let(:estado) { Estado::INICIO }
        it 'puede hacerlo' do
          @ability.can?(:add_material, @requerimiento).should be_truthy
        end
      end

      context 'y el estado es aprobado por el sector y el solicitante es uno de los responsables de dicho sector' do
        let(:sector) { build(:sector, :responsables => [solicitante]) }
        let(:estado) { Estado::APROBADO_X_SECTOR }
        it 'puede hacerlo' do
          @ability.can?(:add_material, @requerimiento).should be_truthy
        end
      end
    end

    context 'si el usuario que desea hacerlo no es el solicitante' do
      let(:solicitante) { build(:usuario) }
      let(:usuario) { build(:usuario) }
      let(:estado) { Estado::INICIO }
      let(:sector) { build(:sector) }
      it 'no puede hacerlo' do
        @ability.can?(:add_material, @requerimiento).should be_falsey
      end
    end

  end

end
