// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
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
    console.log(this);
    console.log(this.action);
    console.log($(this));
    console.log($(this).serialize());
  })

  // Specific date hidden field toggle
  $(".need_by-field").on("change", function() {
    if ($("#need_by option:selected").text().toLowerCase() == "specific date") {
      $("#specific-date").removeClass("need_by-field-hidden");
      $("#specific-date input").val("");
    } else {
      $("#specific-date").addClass("need_by-field-hidden");
    }
  })

});

document.addEventListener("DOMContentLoaded", function(event) {
  $("input[type='email']").val("xrd-admin@hrl.com");
  $("input[type='password']").val("galaxy");
});
