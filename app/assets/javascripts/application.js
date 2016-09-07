//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.timeAutocomplete.min
//= require jquery.timepicker.min

$(function() {

  // AJAXify pagination links
  $(document).on("click", ".pagination a", function() {
    $.getScript(this.href, function(){
      console.log("AJAX!");
    });
    return false;
  });

  // AJAXify search bar
  $(".search").keyup(function() {
    $.get(this.action, $(this).serialize(), null, "script");
    console.log("this", this);
    console.log("this.action", this.action);
    console.log("$(this)", $(this));
    console.log($(this).serialize());
  });

  // Specific date hidden field toggle
  $(".need_by-field").on("change", function() {
    if ($("#need_by option:selected").text().toLowerCase() == "specific date") {
      $("#specific-date").removeClass("need_by-field-hidden");
      $("#specific-date input").val("");
    } else {
      $("#specific-date").addClass("need_by-field-hidden");
    }
  });

  // $("#appointment_start_hour").timeAutocomplete({
  //   increment: 30,
  //   start_hour: 7,
  //   end_hour: 18,
  //   auto_value: false
  // });

  $("#appointment_end_hour, #appointment_start_hour").timepicker({
    'minTime': '7:00am',
    'maxTime': '5:00pm',
    'forceRoundTime': true
  });
});
