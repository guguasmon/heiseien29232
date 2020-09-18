$(document).on('turbolinks:load', function(){
  const x = $(location).attr('pathname');
  const num = x.replace(/[^0-9]/g, '');
  switch (num) {
    case '1':
      $('#monday').addClass('active');
    break;
    case '2':
      $('#tuesday').addClass('active');
    break;
    case '3':
      $('#wednesday').addClass('active');
    break;
    case '4':
      $('#thursday').addClass('active');
    break;
    case '5':
      $('#friday').addClass('active');
    break;
    case '6':
      $('#saturday').addClass('active');
    break;
    case '7':
      $('#sunday').addClass('active');
    break;
    default:
      $('#allday').addClass('active');
    break;
    }
});