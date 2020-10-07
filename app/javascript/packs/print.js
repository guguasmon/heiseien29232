$(function () {
  const list = $('.nav-link')
  $('.printing').on('click', function(){
    list.addClass('print');
    window.print();
    list.removeClass('print');
  });
});