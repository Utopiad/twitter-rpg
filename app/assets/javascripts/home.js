$(document).ready(function(){
  var home = $('.home-container').length;
  console.log(home);
  if ( home ) {
    $('.content-wrapper').addClass('carded');

    $("dropdown-button").dropdown();
  } else  {
    return;
  }

});
