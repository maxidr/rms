require 'spec_helper'

describe Usuario do
  it { should validate_presence_of :nombre }
  it { should validate_presence_of :apellido }
  it { should validate_presence_of :identificador }

  before do
    @usuario = build(:usuario)
  end

  context 'con todos los atributos correctos' do
    it 'debe ser un usuario valido' do
      @usuario.should be_valid
    end
  end

  describe '#rol' do
    context "cuando se crea un usuario sin rol" do
      it "debe utilizar el de 'operador'" do
        Usuario.new.rol.should == 'operador'
      end
    end

    context "cuando se crea un usuario con un rol que no es operador o administrador" do
      it 'el rol debe quedar como operador (por defecto)' do
        usuario = build(:usuario)
        usuario.rol = 'test'
        usuario.rol.should == 'operador'
      end
    end

    context 'para un usuario existente, cuando se trata de cambiar el rol a uno invalido' do
      it 'debe mantener el rol original' do
        usuario = build(:admin)
        usuario.rol = 'blah!'
        usuario.rol.should == 'administrador'
      end
    end

  end

end
