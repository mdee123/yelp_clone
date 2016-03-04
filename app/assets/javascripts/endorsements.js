// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {
  $('.endorsements-link').on('click', function(event) {
    event.preventDefault();

    var endorsermentCount = $(this).siblings('.endorserment_count');

    $.post(this.href, function(response){
      endorsermentCount.text(response.new_endorsement_count);
    });
  });
});
