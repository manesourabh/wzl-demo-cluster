$(document).ready(function() {
  let isOpen = false;
  let $windowWidth = $( window ).width();
  const $btnCollapse = $(".button-collapse");
  const $content = $('#content');

  $( window ).resize(function() {

    $windowWidth = $( window ).width();
    if($windowWidth > 1440) {
      $content.css('padding-left', '250px');
      if(isOpen) {
        $btnCollapse.css('left', '0');
        isOpen = false;
      }
    } else if($windowWidth < 530 && isOpen) {
      $btnCollapse.css('left', '0');
      $content.css('padding-left', '0');
      $('#sidenav-overlay').css('display', 'block');
      $btnCollapse.trigger('click');
    } else {
      if(!isOpen) {
        $content.css('padding-left', '0');
      }
    }
  });

  // SideNav Button Initialization
  $btnCollapse.sideNav();

  $btnCollapse.on('click', () => {
   isOpen = !isOpen;
   if($windowWidth > 530) {
    const elPadding = isOpen ? '250px' : '0';
    $btnCollapse.css('left', elPadding);
     $content.css('padding-left', elPadding);
    $('#sidenav-overlay').css('display', 'none');
   } else {
    $('#sidenav-overlay').on('click', () => {
      isOpen = !isOpen;
    });
   }
  });
  $('#sidenav-overlay').on('click', () => {
    isOpen = !isOpen;
  });
});