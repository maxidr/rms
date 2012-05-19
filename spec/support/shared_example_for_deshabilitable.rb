shared_examples 'deshabilitable' do
  describe '#destroy' do
    before do
      @object = create(described_class.name.downcase.to_sym)
      @object.destroy
    end
    context 'cuando se destruye' do
      it 'deja de estar habilitada' do
        @object.enabled?.should be_false
      end

      it 'debe seguir existiendo' do
        described_class.find(@object.id).should == @object
      end

      it "debe poseer la fecha actual en el atributo 'disabled_at'" do
        @object.disabled_at.should_not be_nil
      end
    end
  end
end
