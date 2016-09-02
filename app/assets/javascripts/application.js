//= require jquery
//= require jquery_ujs

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

});
