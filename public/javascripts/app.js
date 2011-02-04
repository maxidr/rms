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
});

