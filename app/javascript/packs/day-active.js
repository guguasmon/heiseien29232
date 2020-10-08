$(function () {
  const x = $(location).attr('search');
  switch (true) {
    case /^(?=.*visit1_id_eq%5D=1).*$/.test(x):
      $('#monday').addClass('active');
      $('#day-of-the-week').text('月曜日');
    break;
    case /^(?=.*visit1_id_eq%5D=2).*$/.test(x):
      $('#tuesday').addClass('active');
      $('#day-of-the-week').text('火曜日');
    break;
    case /^(?=.*visit1_id_eq%5D=3).*$/.test(x):
      $('#wednesday').addClass('active');
      $('#day-of-the-week').text('水曜日');
    break;
    case /^(?=.*visit1_id_eq%5D=4).*$/.test(x):
      $('#thursday').addClass('active');
      $('#day-of-the-week').text('木曜日');
    break;
    case /^(?=.*visit1_id_eq%5D=5).*$/.test(x):
      $('#friday').addClass('active');
      $('#day-of-the-week').text('金曜日');
    break;
    case /^(?=.*visit1_id_eq%5D=6).*$/.test(x):
      $('#saturday').addClass('active');
      $('#day-of-the-week').text('土曜日');
    break;
    case /^(?=.*visit1_id_eq%5D=7).*$/.test(x):
      $('#sunday').addClass('active');
      $('#day-of-the-week').text('日曜日');
    break;
    default:
      $('#all').addClass('active');
    break;
    }
});