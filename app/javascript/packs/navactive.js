$(document).on('turbolinks:load', function(){
  const x = $(location).attr('pathname');
  const num = x.replace(/[^0-9]/g, '');
  console.log(num);
  switch (num) {
    case '1':
      $('#monday').addClass('active');
      console.log('月曜日');
    break;
    case '2':
      $('#tuesday').addClass('active');
      console.log('火曜日');
    break;
    case '3':
      $('#wednesday').addClass('active');
      console.log('水曜日');
    break;
    case '4':
      $('#thursday').addClass('active');
      console.log('木曜日');
    break;
    case '5':
      $('#friday').addClass('active');
      console.log('金曜日');
    break;
    case '6':
      $('#saturday').addClass('active');
      console.log('土曜日');
    break;
    case '7':
      $('#sunday').addClass('active');
      console.log('日曜日');
    break;
    default:
      $('#allday').addClass('active');
      console.log('全表示');
    break;
    }
});