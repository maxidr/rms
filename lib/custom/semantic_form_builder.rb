module Custom

  class SemanticFormBuilder < Formtastic::SemanticFormBuilder

    JS_FOR_COMBOSELECT = "<script type=text/javascript>
                            $(document).ready(function() {
                              $('#%s').comboselect({addbtn: 'Agregar >', rembtn: '< Quitar'});
                            });
                          </script>"

    private

    def comboselect_input(method, options)
      (JS_FOR_COMBOSELECT % "#{sanitized_object_name}_#{generate_association_input_name(method)}") << select_input(method, options)
    end

  end

end

