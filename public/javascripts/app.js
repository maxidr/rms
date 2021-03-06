$(document).ready(function() {
    $('.datepicker').
    datepicker({ dateFormat: 'dd/mm/yy',
      nextText: 'Prox',
      prevText: 'Ant.',
      dayNamesMin: ["Do","Lu","Ma","Mi","Ju","Vi","Sa"],
      monthNames: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octobre","Noviembre","Diciembre"],
      monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dec"],
      appendText: "dd/mm/aaaa"});

    // Closing notifications
    // this is the class that we will target
    $(".hideit").click(function() {
 	   //fades the notification out
 	   $(this).fadeOut(700);
    });

    $('.accordion').accordion({
      collapsible: true,
      active: false,
      autoHeight: true
    });
    // Zebra tables
    $("tr:nth-child(odd)").addClass("odd");

    $("tr").hover(
      function(){
        $(this).children("td.actions").children().css("visibility", "visible");
      }, function(){
        $(this).children("td.actions").children().css("visibility", "hidden");
    });

    // autogrow text area
    $('textarea').ata();

    // El "fieldset.inputs li.text div" se debe a que el plugin de jquery envuelve el textarea con un div
    // y evita que el evento focus funcione
    $("fieldset.inputs :input, fieldset.inputs li.text div, .csleft").live('focusin', function(){
        $(this).parent("li").addClass("highlight");
    });

    $("fieldset.inputs :input, fieldset.inputs li.text div").live('focusout', function(){
        $(this).parent("li").removeClass("highlight")
    });

    $("fieldset.inputs ol fieldset.complex-inputs :input").live('focusin', function(){
      $(this).parents("fieldset.complex-inputs").addClass("highlight");
    });

    $("fieldset.inputs ol fieldset.complex-inputs :input").live('focusout', function(){
      $(this).parents("fieldset.complex-inputs").removeClass("highlight");
    });

    $("#filters .clean-filters").bind('click', function(event){
      event.preventDefault();
      $("fieldset.inputs :input").val("");
    });

    $("#filters fieldset.inputs :input").each(function(){
      if( $(this).val() != '' ){
        $('.accordion').accordion("activate");
      }
    });


});



