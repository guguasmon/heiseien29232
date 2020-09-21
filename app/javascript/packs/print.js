$(function(){
  const list = $('.nav-link')
  $('.print').on('click', function(){
    list.addClass('print');
    window.print();
    list.removeClass('print');
  });
});