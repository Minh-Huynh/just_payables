$(document).ready(function() {
  $(".clickable-row").click(function() {
      window.location = $(this).data("href");
  });

  $(".filter_datepicker").datepicker( {
  format: "mm-yyyy",
  startView: "months", 
  minViewMode: "months"
  });

  $(".filter_datepicker").on("keyup", function(e){
    console.log("test");
      if(e.which == 13){
           $(this).closest('form').submit();
       }
    });
});