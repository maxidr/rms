$(document).ready(function() {
	if( $("#new_compra .inline-errors").length == 0 ){
		$("#new_compra").hide();
	}

	$("#comprar").click(function(event){
		$("#new_compra").fadeIn('slow', function(){
			$("#compra_fecha_probable_entrega_3i").focus();
		});
		event.preventDefault();
	});
});

