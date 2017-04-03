//toggle search on lg screens

jQuery(document).ready(function($) {
    var mqlSubToggles = window.matchMedia("(max-width: 768px)");

    function addToggles() {
        $('.headerMain-navItems li.hasChildren').prepend('<span class="navMain-mobileSubToggle" />'); 
    }

    function toggleSubs() {
        $('.navMain-mobileSubToggle').on("click.mqlSubToggles", function() {
            $(this).closest('li').toggleClass('is-open');
        }); 
    }

    function resetToggles() {
        $('.navMain-mobileSubToggle').remove();
        $('.headerMain-navItems li.is-open').removeClass('is-open');
    }

    function screenSize(mqlSubToggles) {
      if (mqlSubToggles.matches) {
        addToggles();
        toggleSubs();
      } else {
        resetToggles();
      }
    }

    // Handle media query 'change' event
    mqlSubToggles.addListener(screenSize);
    screenSize(mqlSubToggles);
});