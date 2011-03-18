$(document).ready(function() {
  $(".precio_con_iva").live('focusout', function(){
    id = this.id;
    value = $(this).val();
    alert( "Value for " + id + " is " + value);
    //presupuesto_desgloses_attributes_0_precio_unitario
    //presupuesto_desgloses_attributes_0_precio_unitario_con_iva
  });
  
});
