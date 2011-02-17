$(document).ready(function() {
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

//    $("td.actions a:first").button({
//      icons: {primary: "ui-icon-locked"}, label: "ver"
//    });
});

