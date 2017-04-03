
$.fn.toggler = function() {

  return this.each( function() {

    $(this).click(function(event) {

      // Prevent click event on a tag
      if ($(this).is('a')) {
        if(event.preventDefault) { event.preventDefault(); }  
      }

      $target = $(this).data('toggle')
      $elem   = $('#' + $target);
      $height = $elem.prop('scrollHeight');

      // Remove inline max-height
      if (typeof $elem.attr('style') !== typeof undefined && $elem.attr('style') !== false) {
        $elem.removeAttr('style');
      }
      else {
        $elem.css('max-height', $height);
      }

      // // Do something based on toggle target, eg scroll to position of element etc ..
      // switch ($target) {
      //   case 'toggle-3':
      //     $elem.toggleClass('active').css('background-color', 'red');
      //   break;

      //   default:

      //     $elem.toggleClass('active');
      //   break;
      // }
    });
  });
};
