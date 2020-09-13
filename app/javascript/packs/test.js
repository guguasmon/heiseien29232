$(document).on('turbolinks:load', function(){
  $('p').on('click', function() {
    $(this).css('color', 'blue');
  });
});