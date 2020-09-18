$(document).on('turbolinks:load', function(){
  const x = $(location).attr('pathname');
  console.log(x);
  switch (true) {
    case x.includes('/guests/new'):
      $('#entry').addClass('active');
      console.log('利用者を登録する');
    break;
    case x.includes('baths'):
      $('#bath-index').addClass('active');
      console.log('入浴形態表');
    break;
    case x.includes('drinks'):
      $('#drink-index').addClass('active');
      console.log('水分提供表');
    break;
    default:
      $('#guest-index').addClass('active');
      console.log('利用者一覧');
    break;
    }
});