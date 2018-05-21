$(document).ready(function() {
  $(".clickable-row").click(function() {
      window.location = $(this).data("href");
  });
  $(".order_datepicker, .filter_datepicker").datepicker({
    format: "mm-yyyy",
    startView: "months", 
    minViewMode: "months"
  });

  $(".orders_container").on('keyup', '.filter_datepicker', function(e){
      if(e.which == 13){
           $(this).closest('form').submit();
       }
    });
  $(".orders_container").on('keyup', '.order-search', function(e){
      if(e.which == 13){
           $(this).closest('form').submit();
       }
    });

  $(".orders_container").on('click','.received-btn', function(event) {
    event.stopPropagation();
  });
  $(".orders_container").on('click','.paid-btn', function(event) {
    event.stopPropagation();
  });
});