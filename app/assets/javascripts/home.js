$(document).ready(function(){
  var home = $('.home-container').length;
  console.log(home);
  if ( home ) {
    $('.content-wrapper').addClass('carded');

  } else  {
    return;
  }

});
