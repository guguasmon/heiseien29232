$(document).on('turbolinks:load', function(){
  const x = $(location).attr('search');
  const num = x.slice(-1)
  switch (num) {
    case '1':
      $('#monday').addClass('active');
      $('#day-of-the-week').text('月曜日');
    break;
    case '2':
      $('#tuesday').addClass('active');
      $('#day-of-the-week').text('火曜日');
    break;
    case '3':
      $('#wednesday').addClass('active');
      $('#day-of-the-week').text('水曜日');
    break;
    case '4':
      $('#thursday').addClass('active');
      $('#day-of-the-week').text('木曜日');
    break;
    case '5':
      $('#friday').addClass('active');
      $('#day-of-the-week').text('金曜日');
    break;
    case '6':
      $('#saturday').addClass('active');
      $('#day-of-the-week').text('土曜日');
    break;
    case '7':
      $('#sunday').addClass('active');
      $('#day-of-the-week').text('日曜日');
    break;
    default:
      $('#allday').addClass('active');
    break;
    }
});