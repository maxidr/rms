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
      @ability.can?(:aprobar_por_sector, @rqm).should be_true
    end

    it 'no puede ser aprobado por un usuario que no es encargado del sector' do
      sector.stub_chain(:responsables, :exists?) { false }
      @rqm.sector = sector
      @ability.can?(:aprobar_por_sector, @rqm).should be_false
    end
  end

end
