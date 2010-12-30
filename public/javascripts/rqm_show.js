$(document).ready(function() {
	$("#new_compra").hide();
	
	var dt = new Date();
	$("#entrega_fecha_1i").val(dt.getFullYear());
	$("#entrega_fecha_2i").val(dt.getMonth());
	$("#entrega_fecha_3i").val(dt.getDay());
	
	$("#comprar").click(function(event){
		$("#new_compra").fadeIn('slow', function(){
			$("#entrega_fecha_3i").focus();
		});
		event.preventDefault();
	});
});
