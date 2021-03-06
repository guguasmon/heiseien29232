$(function () {
  const x = $(location).attr('pathname');
  switch (true) {
    case x.includes('/guests/new'):
      $('#entry').addClass('active');
    break;
    case x.includes('lookup'):
      $('#lookup-index').addClass('active');
    break;
    case x.includes('baths'):
      $('#bath-index').addClass('active');
    break;
    case x.includes('drinks'):
      $('#drink-index').addClass('active');
    break;
    case x.includes('foods'):
      $('#food-index').addClass('active');
    break;
    default:
      $('#guest-index').addClass('active');
    break;
    }
});