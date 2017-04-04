var orientationTimer;
var vpw = document.documentElement.clientWidth;

$(window).load(function () {
    //mosaic gap fixer
    //    gapFix();
    if ($('[data-expander]').length > 0) $('[data-expander]')[0].expandMe();

    if ( ($('.matchThis').length >= 0) && (vpw >= 768 ) ) {
        $('.matchThis').each(function () {
            $(this)[0].matchHeight();
        });
    }

    if ( ($('#more').length > 0) && (vpw >= 768) ) {
        $('#more').each(function () {
            morePanels.init($(this));
        });
    }
	
	if ($('.people-list.stacked').length > 0) {
		lemmonInit();
    };

    $(".mosaic .tile .caret").removeClass("caret").addClass("glyphicon glyphicon-menu-down form-arrow-down");
	
});


function initSearch(){
    
     $('.search .search-btn .fa-search').click(function (e) {
          e.preventDefault();
          e.stopPropagation();
          $('.search-form').toggleClass('hovered');
          $('#nav-overlay').toggleClass('darkened');
          $('#p_lt_ctl00_WebPartZone1_WebPartZone1_zone_ManattSmartSearchBox_txtWord').focus(); 
      });
        
      $('.search .search-btn #p_lt_ctl00_WebPartZone1_WebPartZone1_zone_ManattSmartSearchBox_txtWord').click(function (e) {
          //if(e.toElement.id == "p_lt_ctl00_WebPartZone1_WebPartZone1_zone_ManattSmartSearchBox_txtWord")
              return false;          
      });

      $('body').click(function(e){
          $('.search-form').removeClass('hovered');
          $('#nav-overlay').removeClass('darkened');
      });  
    
}

$(document).ready(function () {

    $("#twitterCarousel .item:first-of-type").addClass( "active" );
    // $("#twitterCarousel")..mouseover();
    
    var isMobile = 'ontouchstart' in window || navigator.maxTouchPoints;
    var isIpadDimension = ('ontouchstart' in window || navigator.maxTouchPoints) && window.innerWidth >= 1024;
	
	var mobileMenuDisplay = function() {
		var e = $('.site-nav .navbar-toggle')[0];
		
		return e.currentStyle ? e.currentStyle.display :
		getComputedStyle(e,null).display;
	}

    if ($('[data-toggle="tooltip"]').length > 0) $('[data-toggle="tooltip"]').tooltip();
    
    if(isMobile && location.pathname == '/'){    	
    	//redirect go button action to global search instead of people search    	
    	$('form').on('submit', function(e) {        	
        	var globalTextWord = $('#p_lt_ctl00_WebPartZone1_WebPartZone1_zone_ManattSmartSearchBox_txtWord').val();
        	if(globalTextWord.length > 0)
        	{
        		e.preventDefault();        		
        		window.location.href = "/search?searchmode=exactphrase&searchtext=" + globalTextWord;
        	}
        	else{        		
        		return true;       	        
        	}
    	});
    }
    
    if(isIpadDimension){
           initSearch();
        
    }
    
    if ( (mobileMenuDisplay() != 'block') && (!isMobile) ) {
		var overlayDelay = null;
        // Mian navigation: highlighting the hovered items
        $('.site-nav .nav > .dropdown:not(.ignore)').hoverIntent({ over: hoverOn, out: hoverOff, sensitivity: 300, timeout: 200 });
      $('nav.site-nav .navbar-inner .nav-pills ').hoverIntent({ over: hoverOnNav, out: hoverOffNav, timeout: 200, sensitivity: 150 });        
//        $('.site-nav .nav > .dropdown.hovered').hoverIntent({ over: hoverOn, out: hoverOff, timeout: 800, sensitivity: 50 });
       //$('.site-nav .nav > .dropdown:not(.ignore).hovered').hoverIntent({ over: hoverOn, out: hoverOffSub, timeout: 800, sensitivity: 50 });
      $('.site-nav .dropdown .two-tier > li').hoverIntent({ 
            over: hoverOn, 
            out: hoverOff, 
            timeout: 100, 
            sensitivity: 80 
      });  
        
     initSearch();
        
//      $('.search .search-btn .fa-search').click(function (e) {
//          e.preventDefault();
//          e.stopPropagation();
//          $('.search-form').toggleClass('hovered');
//          $('#nav-overlay').toggleClass('darkened');
//          $('#p_lt_ctl00_WebPartZone1_WebPartZone1_zone_ManattSmartSearchBox_txtWord').focus(); 
//      });
//        
//      $('.search .search-btn #p_lt_ctl00_WebPartZone1_WebPartZone1_zone_ManattSmartSearchBox_txtWord').click(function (e) {
//          //if(e.toElement.id == "p_lt_ctl00_WebPartZone1_WebPartZone1_zone_ManattSmartSearchBox_txtWord")
//              return false;          
//      });
//
//      $('body').click(function(e){
//          $('.search-form').removeClass('hovered');
//          $('#nav-overlay').removeClass('darkened');
//      });
        
      //$('.search .search-btn').hoverIntent({
      //      over: function () {
      //          $('.search-form').addClass('hovered');
      //          $('#nav-overlay').addClass('darkened');
      //      }, out: function () {
      //          $('.search-form').removeClass('hovered');
      //          $('#nav-overlay').removeClass('darkened');
      //      }, timeout: 300, sensitivity: 5, interval: 100
      //  });

        $('.nav li.dropdown.ignore').click(function () {
            var that = $(this);
            //if the drop button has the ignore class
            //return without doing anything
            var uri = $(this).find('a').attr('href');
            window.location.href = uri;
        });
        
        $('.site-nav a[href="#"]').on('click', function() {
	        return false;
        });
        
        if( isMobile ) {
	        var clickCount = 0;
	        
	        //ignore first header clicks on ipad to open submenu
	        $('.site-nav .dropdown-menu.two-tier > li > a').on('click', function() {
	            return false;
	        });
        }

    } else {
        mobileMenuInit();
    }
    
    
  
    function hoverOn(e) {
       /* if ($( ".site-nav .nav > .dropdown:not(.ignore)" ).is( "hovered" ) ) {
           $('#nav-overlay').addClass('darkened');
        } */
	   if ($(this).attr('class') == 'dropdown ignore'){
            $(this).addClass('hovered');
            $('#nav-overlay').removeClass('darkened');
        } else {
            $(this).addClass('hovered');
            $('#nav-overlay').addClass('darkened');

            //			if( overlayDelay != null ) {
            clearTimeout(overlayDelay);
            overlayDelay = null;
        }
    }
    function hoverOff() {
        $(this).removeClass('hovered');
    
        clearTimeout(overlayDelay);
        overlayDelay = null;

        overlayDelay = setTimeout(function () {
            //$('#nav-overlay').removeClass('darkened');
            $('#nav-overlay').removeClass('second-dark');
        }, 800);
    }
  
    function hoverOffSub() {
        setTimeout(function () {
            $(this).removeClass('hovered');
        }, 800);
    }

    function hoverOnNav() {
        $('#nav-overlay').addClass('darkened');
    }
    function hoverOffNav() {
        setTimeout(function () {
            $('#nav-overlay').removeClass('darkened');
        }, 800);
    }

    function mobileMenuInit() {
        var menuStatus = $('.nav .dropdown-menu').css('display');

        $('.navbar-toggle').on('tap', function () {
            if (parseInt($('#nav-overlay').css('height')) === 0) {
                $('#nav-overlay').addClass('darkened');

            } else {
                $('#nav-overlay').removeClass('darkened');
            }
        })
        
        $('.site-nav .nav > li.dropdown:not(.ignore)').off().on('click', function () {
            var that = $(this);
            //if the drop button has the ignore class
            //return without doing anything

            if ($(this).attr('class').indexOf('ignore') != -1) {
                //if the drop button has the ignore class
                //return without doing anything
                var uri = $(this).find('a').attr('href');
                window.location.href = uri;
            }

            var cont = $(this).parents('.collapse');
            var menu = $(this).find('.dropdown-menu')[0];
            var mClass = $(this).attr('class');
			
            if (mClass.indexOf('hovered') === -1) {
                if ($('.nav .hovered').length > 0) {
                    $('.nav .hovered').removeClass('hovered');
                }

                $(this).addClass('hovered');
                $('html, body').stop(true, false).animate({ scrollTop: $(this)[0].offsetTop });
            } else if (mClass.indexOf('hovered') != -1) {
                $(this).removeClass('hovered');

            } else {
            }
        });
		
		$('.site-nav .nav > .ignore, .site-nav .nav-links').off().on('click', function () {
			var uri = $(this).find('a').attr('href');
            window.location.href = uri;
		});
		
        $('.site-nav .dropdown-menu.two-tier > li').off().on('click', function () {
            var that = $(this);
            var thatLink = that.find('a');
            var thatClass = that.attr('class');

            if (thatClass === 'hovered') {
                // that.removeClass('hovered');
                // thatLink.css({ 'background': 'transparent' });
              return true;

            } else {
                that.addClass('hovered');
                thatLink[0].style.cssText = '';

            }
            return false;
        });
    }
	
	//adds space after periods that run into text
	if( $('.results-container p').length > 0 ) {
		$('.results-container p').each(function() {
			var html = $(this).html().replace(/(\.+)(?!\W|\d)/g, '.  ');
			$(this).html(html);
		});
	};
	
    //checks for video in jumbotron slider and hijacks
    //to prevent the slider from running over the video
     var video = $('.carousel-inner').find('video');

     if (video.length >= 0) {
         sliderControl.init(video);

         //listen to slider and when it shows a new slide
         //check if its the video
         $('#hero-slider .carousel').on('slid.bs.carousel', sliderControl.checkSlide);
     };

    //style select menus
    if ($('.selectpicker, select').length > 0) {
        $('.selectpicker, select').selectpicker({
            selectOnTab: true
        });

        $('.selectpicker, select').on('changed.bs.select', function () {
            var selects = $(this).parent().find('.selectpicker');
            selects.not($(this)).selectpicker('hide');

            $(this).parents('.btn-group').removeClass('open');
        });
    }

    //make datepickers
    if ($('.datepicker').length > 0){
        $('.datepicker').datepicker();
        $('.datepicker').each(function(){
           $(this).prop("autocomplete","off"); 
        });
    }
	
    //expands search box on desktop
    //button is hidden on mobile and search is shown
    //so no mobile checks are needed for this
    
    //$('nav .search .search-btn').on('click', searchExpander);

    //Search box: Send input value to search page
    $("#bntSubmitSearch").on('click', function (event) {
        event.preventDefault();
        var searchText = $("input[name$='$ManattSmartSearchBox$txtWord']").val();
        if(searchText.trim() == "Search" || searchText.trim() == "")
            return false;
        
        window.location.href = "/search?searchmode=exactphrase&searchtext=" + searchText;
    });
    $(document).keydown(function(e) {
      if (e.which == 13) {
        if ($("div.form-inline.search-form.hovered").length)
          return;
        if ($("#career-keyword").length) {
          location.href='/careers/current-opportunities?searchtext=' + document.getElementById('career-keyword').value;
          return false;
        }
        if ($("input[name$='$srchDialog$btnSearch']").length) {
          $("input[name$='$srchDialog$btnSearch']").click();
          return false;
        }
        if ($("input[name$='$ManattSmartSearchBox$btnSearch']").length) {
          $("input[name$='$ManattSmartSearchBox$btnSearch']").click();
          return false;
        }        
      }
    });
   $("input[name$='$srchDialog$btnSearch'],input[name$='$ManattSmartSearchBox$btnSearch']").click(function () {
     $("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl03$SearchText$txtFilter']").val($("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl03$ManattSmartSearchBox$txtWord']").val());
        $("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl02$SearchText$txtFilter']").val($("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl02$ManattSmartSearchBox$txtWord']").val());
        $("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl01$SearchText$txtFilter']").val($("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl01$ManattSmartSearchBox$txtWord']").val());
         
     var waterMark = [ 'Search', 'Name' ];
        if (waterMark.indexOf($("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl03$ManattSmartSearchBox$txtWord']").val()) > -1)
          $("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl03$ManattSmartSearchBox$txtWord']").val("");
        if (waterMark.indexOf($("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl02$ManattSmartSearchBox$txtWord']").val()) > -1)
          $("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl02$ManattSmartSearchBox$txtWord']").val("");
        if (waterMark.indexOf($("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl01$ManattSmartSearchBox$txtWord']").val()) > -1)
          $("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl01$ManattSmartSearchBox$txtWord']").val("");
        if (waterMark.indexOf($("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl03$SearchText$txtFilter']").val()) > -1)
          $("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl03$SearchText$txtFilter']").val("");
        if (waterMark.indexOf($("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl02$SearchText$txtFilter']").val()) > -1)
          $("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl02$SearchText$txtFilter']").val("");
        if (waterMark.indexOf($("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl01$SearchText$txtFilter']").val()) > -1)
          $("input[name$='p$lt$ctl02$pageplaceholder$p$lt$ctl01$SearchText$txtFilter']").val("");      

       
    });  
  
    //play video on button click
    $('.video .btn').off('click').on('click', function () {
        //        return false;


        var video = $(this).parent().find('video')[0];
        var btn = $(this);

        if (!$(video).attr('controls')) {
            $(video).attr({ 'controls': 'controls' });
        }

        function togglePlay() {
            if (!video.paused) {
                video.pause();
                btn.fadeIn();
            } else {
                btn.fadeOut();
                video.play();
            }
        }

        togglePlay();

        //add listener to bring play button back
        $(video).on('ended', function () {
            $(video).removeAttr('controls');
            video.currentTime = 0;
            btn.fadeIn();
        });

        $(video).off('click').on('click', togglePlay);
    })

    //read more expander
    var vpw = document.documentElement.clientWidth;


    $('[data-expander-toggle]').on('click', expander.toggleMoreOpen);
    if ( ($('.sub .nav li').length > 3) && ($('.sub .nav li').length <= 6) ) {
        $('.sub').addClass('long');
    } else if ( $('.sub .nav li').length >= 6) {
        $('.sub').addClass('long shrink');
    }

    if ( ($('#more').length > 0) && (vpw >= 768) ) {
	    $('.sub:not(".static") .nav li a[href="#"]').on('click', morePanels.navigate);
    }
    $('.panel').on('show.bs.collapse', function (e) {
        var panel = e.currentTarget;
        var button = $(panel).find('.panel-heading a[role="button"]');

        if ($(button).attr('class') != undefined) {
            var bc = $(button).attr('class').indexOf('fa-plus');
        } else {
            return true;
        }

        if (bc != -1) {
            $(button).removeClass('fa-plus').addClass('fa-minus')
        }
    });

    $('.panel').on('hide.bs.collapse', function (e) {
        var panel = e.currentTarget;
        var button = $(panel).find('.panel-heading a[role="button"]');

        if ($(button).attr('class') != undefined) {
            var bc = $(button).attr('class').indexOf('fa-minus');
        } else {
            return true;
        }
        if (bc != -1) {
            $(button).removeClass('fa-minus').addClass('fa-plus')
        }
    });


    //listen to sub menu mobile accordion clicks to only have one open
    $('.collapse').on('show.bs.collapse', function (e) {
        //hide others
        if(!(e.target.id == "collapseOne" || e.target.id == "collapseTwo" || e.target.id == "collapseThree" ))
            $('#more .in').not($(this)).not($('#careers #more .in')).collapse('hide');
    });
    
    $('.mosaic #practices .show-more').on('click', expander.toggleMoreOpen);

    if ($('.carousel-inner').length > 0) {
        var c = $('.carousel-inner');
        if (isMobile && c.length > 0) {
            //TODO REVISE FOR MULTIPLE SLIDERS ON PAGE
            //			mobilizeBSCarousel.init( c[0] );
        }
    }

    // If there's a video slider, force it's ratio to be the same as other slides
    if (($('#hero-slider video').length > 0) && ($('#hero-slider .item').length > 1)) {
        // find the image ratio on the first image slide
        heroHgt = $('#hero-slider .item > img').height();
        heroWdt = $('#hero-slider .item > img').width();
        heroRatio = heroHgt / heroWdt;

        // set the video height to match the image
        function videoSliderHeight() {
            $('#hero-slider video').css({ height: ($(window).width() * heroRatio) });
        }
        // adjust video height on resize
        $(window).on('resize', function () {
            videoSliderHeight();
        });
        // set video size on page load
        videoSliderHeight();
    }

    $('.dropdown-menu').on('click', function (e) {
        e.stopPropagation();
    });

//	//change input types from text to date on date fields
//	$('#search-filter input[name*="Date"]').on('focus', function() {
//		var attr = $(this).attr( 'type' );
//
//		if ( attr === 'hidden') return;
//		$(this).attr({
//			'type' : 'date'
//		});
//	});
//	
//	$('#search-filter input[name*="Date"]').on('blur', function() {
//		var attr = $(this).attr( 'type' );
//
//		if ( attr === 'hidden') return;
//		$(this).attr({
//			'type' : 'text'
//		});
//	});

    //listen to mobile orientation change
    var orientation = window.matchMedia("(orientation: portrait)");
    orientation.addListener(orientationChange);

    //print page controls
    printPageControl.init();
});

function lemmonInit() {
	$('#peopleSlider').lemmonSlider({
            'infinite': true,
//            'slideToLast': true
	});

	//set slider ul width as lemmon slider keeps making it too small
	var h = 0;
	$('#peopleSlider ul li').each( function() {
		h += $(this).height();
	});
	if ($('#peopleSlider ul li').length > 0) {
        if(h == 0)
            h = 50000;
		$('#peopleSlider ul')[0].style.cssText = 'width:'+h+'px!important;';
	}	
	$('#peopleSlider .controls a').click(function (e) {
		e.preventDefault;
		e.stopPropagation;
	});
}

var printPageControl = {
    args: {
        trigger: $('.print-control input[type="checkbox"]'),
        item: null,

    },
    init: function () {
        //this.args.trigger.on('click', printPageControl.clickHandler);
        this.args.trigger.on('change', printPageControl.changeHandler);
        //		printPageControl.printDisplay();
        $('.print.btn').on('click', printPageControl.callPrintDialog)
        //$('.print-nav .nav .download.btn').on('click', printPageControl.getPDF)

    },
    printDisplay: function () {
        $('[data-expander-toggle]').click();
        $('#more .collapse').css({ 'padding-top': '16px' });
        $('.sub').hide();

    },
    changeHandler: function (e) {
        item = $(this).siblings('label').attr('data-item');
        
        if(this.checked){            
            $(item).removeClass('hide');    
        }   
        else{            
            $(item).addClass('hide');
        }  
        
        // var length = $(item).length;
        // if(length > 0)
        // {        
        //     var top = parseInt($(item)[length-1].offsetTop);
                           
        //     //scroll to elelemtn
        //     $('html,body').animate({
        //         scrollTop: top
        //     }, 250);    
        // }

    },
    clickHandler: function (e) {
        item = $(this).attr('data-item');
              
        var top = parseInt($(item)[1].offsetTop);
        var display = getComputedStyle($(item)[0]).getPropertyValue('display');

        //show/hide element
        if (display === 'block') {
            $(item).fadeOut(function () {
                $(item).removeClass('in active');
                $(item)[0].style.cssText = 'display: none!important;'

            });

        } else {
            $(item).fadeIn(function () {
                $(item)[0].style.cssText = 'display: block!important;'


            });
        }

        //scroll to elelemtn
        $('html,body').animate({
            scrollTop: top
        }, 250);

        //		e.preventDefault();
        //		e.stopPropagation();

    },
    callPrintDialog: function (e) {
        window.print();

    },
    getPDF: function (e) {
        $('body').addClass('print');
        var frame = '<iframe width="612" height="800" id="pdf"></iframe>';
        var html = $('body')[0].innerHTML;

        $('body').prepend(frame);
        var f = $('#pdf');

        f.contents().find('body').html(html);
        f[0].focus();

        f[0].save();
        setTimeout(function () { $('body').removeClass('print') }, 1000);

    }
}
    
function orientationChange(m) {
    var isPortrait = m.matches;
    var video = $('.carousel-inner').find('video');
    orientationTimer = null;

    if (orientationTimer != null) {
        clearTimeout(orientationTimer);
        orientationTimer = null;

    }

    orientationTimer = setTimeout(function () {
        clearTimeout(orientationTimer);
        orientationTimer = null;

        //		gapFix();
        sliderControl.init(video);
    }, 500);
}

var mobilizeBSCarousel = {
    init: function (c) {
        $(c).parent().addClass('no-hover');
        $(c).swipe({
            swipeLeft: function (e, dr, ds, dur, fingersCount, fingerData) {
                mobilizeBSCarousel.trigger(c, dr);

            },
            swipeRight: function (e, dr, ds, dur, fingersCount, fingerData) {
                mobilizeBSCarousel.trigger(c, dr);

            },
            threshold: 20,
            fingers: 'all'


        });
    },
    trigger: function (c, d) {
        if (d === 'left') {
            $(c).parent().carousel('next');
        } else {
            $(c).parent().carousel('prev');

        }


    }
}

//simple expander
HTMLElement.prototype.expandMe = function (e) {
    var maxWidth = this.getAttribute('data-expander-max-width');
    if (maxWidth) {
        expander.init(maxWidth, this);
    } else {
        expander.init(this);

    }
}

HTMLElement.prototype.matchHeight = function (e) {
    var self = this;
    var matchee = self.getAttribute('data-source');
    var nh = $(matchee).height();


    self.style.cssText = 'height : ' + nh + 'px!important;';
}

var expander = {
    init: function (maxWidth, expander) {
        //find instances of expander and get them set up
        var expanders = expander || $('body').find('[data-expander]');
        var eLen = expanders.length;

        var e = 0;

        for (e; e <= eLen; e++) {
            this.setExpanderChildren(expanders[e]);
        }
    },
    setExpanderChildren: function (el) {
        if (el === undefined) return false;
        var vpw = document.documentElement.clientWidth;
        var parent = $(el).parent();
        var show = $(el).data('expander-show');
        var offset = $(el).data('expander-offset');
        var max = $(el).data('expander-max-width');
        var children = $(el).children();
        var allChildren = $(el).children();
        var cSplit = children.splice(offset);
        var range = cSplit.splice(0, show);
        var hideGroup = cSplit.copyMe();
        var cLen = allChildren.length;
        var wrapper = null;
        var c = 0;
        var newHeight = 0;
        var maxHeight = 0;
        var outter = 0;
        var hardSizing = false;

        //apply outter text
        var btn = $(parent).find('.expander-toggle');
        var btnSpan = $(btn).find('span');
        var btnText = $(btn).attr('data-text');
		
		if (range.length === 0 || hideGroup.length === 0) {
            $(btn).remove();
            return false;
        }

        if (vpw >= max) {
			$(btn).remove();
            this.destroy(el);
            return false;
        }

        if (el.offsetParent === null) {
            hardSizing = true;
            $(parent).css({ 'visibility': 'hidden', 'display': 'block', 'position': 'absolute' });

        }

		if( $(btn).attr('class') === undefined ) {
			$(parent).append('<button class="expander-toggle animated-fast show hidden-sm hidden-md hidden-lg" data-expander-toggle=""><span>Show More </span><i class="fa fa-caret-down"></i></button>');
			console.debug('added button')
		}
        //add text from more button
        if (btnText === undefined) btnText = '';
        $(btnSpan).html('Show More ' + btnText);

        //		$(range).addClass('border-bottom');
        $(hideGroup).wrapAll('<div class="expander-wrapper clearfix">');
        wrapper = $(el).find('.expander-wrapper');
        newHeight = $(wrapper)[0].clientHeight;
        wrapper.css({ 'overflow': 'hidden' });

        if (hardSizing) {
            $(parent).css({ 'visibility': 'visible', 'display': 'none', 'position': 'relative' });
            //clears inline css on mobile - excluding from the original arg
            //doesnt work as it will leave the display: none which breaks
            //bootstraps accordion functionality
            if (vpw < 768) {
                $(parent)[0].style.cssText = '';


            }
        }

        var lastVisibleEl = $(range)[range.length - 1];
        var secondLastVisibleEl = $(range)[range.length - 2];
        var lastHiddenEl = $(cSplit)[cSplit.length - 1];
        var secondlastHiddenEl = $(cSplit)[cSplit.length - 2];

        if (lastVisibleEl != undefined) {
            var lastDisplay = getComputedStyle(lastVisibleEl, null).getPropertyValue('display');
            var lastFloat = getComputedStyle(lastVisibleEl, null).getPropertyValue('float');


            if ((lastDisplay != 'block') || lastFloat === 'left' || lastFloat === 'right') {
                $(lastVisibleEl).addClass('border-bottom off');
                $(secondLastVisibleEl).addClass('border-bottom off')

            } else {
                $(lastVisibleEl).addClass('border-bottom off');

            }


        }

       $(wrapper).css({ 'height': 0, 'padding-bottom': 0 }).attr({ 'data-new-height': newHeight });
    },
    toggleMoreOpen: function (e) {
        var cur = $(e.currentTarget);
        var parent = e.currentTarget.parentElement;
        var hidables = $(parent).find('.hide');
        var container = $(parent).find('.expander-wrapper') || parent;
        var arrow = $(parent).find('.expander-toggle i.fa');
        var maxHeight = $(container).attr('data-max-height');
        var newHeight = $(container).attr('data-new-height');
        var ex = $(container).attr('data-expander-scrollto');
        var last = $(parent).find('.last-visible');
        var lMargin = $(last).attr('data-margin');
        var lPadding = $(last).attr('data-padding');
        var btnText = cur.attr('data-text');
        if (btnText === undefined) btnText = '';

        if (ex) var exTop = $('.' + ex)[0].offsetTop || $('#' + ex)[0].offsetTop;

        if (container.length > 1) {
            $(container).each(function () {
                newHeight = $(this).attr('data-new-height');


                toggle($(this));
            });
        } else {
            toggle($(container));

        }

        function toggle(container) {
            if ($(container).attr('class') && $(container).attr('class').indexOf('open') != -1) {
                $(container).animate({ 'height': 0 }, 150, function () {
                    $(container).removeClass('open').css({ 'padding-bottom': 0 });
                    $(last).css({ 'margin-bottom': 0, 'padding-bottom': 0 });
                    $('.border-bottom').removeClass('on').addClass('off');


                });
            } else {
                $(last).css({ 'margin-bottom': lMargin, 'padding-bottom': lPadding });
                //console.log(newHeight);
                $(container).animate({ 'height': newHeight }, 150).css({ 'padding-bottom': "0.3em" });;
                $(container).addClass('open');
                $('.border-bottom').removeClass('off').addClass('on');

                if (ex) $('html,body').animate({ 'scrollTop': exTop });


            };
        }
        //switch arrow if its there
        if (arrow.length > 0) {
            if ($(arrow).attr('class').indexOf('fa-angle-down') != -1) {
                $(arrow).removeClass('fa-angle-down').addClass('fa-angle-up');

                $('.expander-toggle span').html('Show Less ' + btnText).blur();
                //				$('#more .close span').html('Show Less '+btnText);

            } else {
                $(arrow).removeClass('fa-angle-up').addClass('fa-angle-down');

                $('.expander-toggle span').html('Show More ' + btnText);
                //				$('#more .close span').html('Show More '+btnText);


            };
        }
        return false;

    },
    destroy: function (el) {
        var toggle = $(el).parent().parent().find('.expander-toggle i.fa');
        var expander = $(el).find('.expander-wrapper');

        $(expander).children().unwrap().addClass('unwrapped');

        if (toggle !== undefined && toggle.length > 0) {
            if ($(toggle).attr('class').indexOf('fa-angle-up') != -1) {
                $(toggle).removeClass('fa-angle-up').addClass('fa-angle-down');



            };
        }
    },
    resize: function (el) {
        var hardSizing = false;
        var vpw = document.documentElement.clientWidth;
        var max = $(el)[0].getAttribute('data-expander-max-width')

        if (el.offsetParent === null) {
            hardSizing = true;
            $(parent).css({ 'visibility': 'hidden', 'display': 'block', 'position': 'absolute' });

        }

        var wrapper = $(el).find('.expander-wrapper');
        if ($(wrapper).attr('class') === undefined) {
            expander.setExpanderChildren(el);
            return false;

        }

        $(wrapper).css({ 'height': 'auto' });
        newHeight = $(wrapper).outerHeight();

        //$(wrapper).attr({ 'data-new-height': newHeight });
        if (($(wrapper).attr('class') != undefined) && ($(wrapper).attr('class').indexOf('open') != -1)) {
            $(wrapper).css({ 'height': newHeight });
        } else {
            $(wrapper).css({ 'height': 0 });

        }

        if (hardSizing === true) {
            hardSizing = false;
            $(parent).css({ 'visibility': 'visible', 'display': 'block', 'position': 'relative' });


        }
    }
}

// add logic for when #more has .closed
// will need to open the overview container
// before sliding in content
var morePanels = {
    init: function (container, item) {
        var vpw = document.documentElement.clientWidth;
        var items = container.find('.collapse').not('.panel-collapse');
        var links = $('.sub ul li');
        var active = container.find('div.active');
        var activeLink;
        if (active.length <= 0) {
            active = container.find('.in');
            if (active.length > 1) {
                active = active[0];
            }
        }

        $(active).addClass('active');
        activeLink = $(active).index('#more .col-md-6');
        $(links).removeClass('active');
        $(links[activeLink]).addClass('active');
        //		}

        if (vpw >= 768) {
            //$(items).not('#collapseOverview').hide();//do not include overview collapse
//            $(active[0]).show();
        } else {
            $(active).removeClass('active');
            $(items).each(function () {
                $(this)[0].style.cssText = '';
            })
        }

        morePanels.checkHash();
    },
    navigate: function (e) {
		var scrollLoc = $('.sub')[0].offsetTop;
        var target = e.currentTarget || e;
        var hash = $(target).attr('title').toLowerCase();
        var container = $('#more');
        var tId = $(target).index('.sub .nav li a');
        var items = $('#more > .collapse');
        var item = items[tId];
        var exp = $(item).find('[data-expander]');
        var vpw = document.documentElement.clientWidth;

        $('html,body').animate({ scrollTop: scrollLoc });

        //if the more div is closed - open it to reveal new content
        if ($(container).attr('class').indexOf('closed') != -1) {
            $(container).removeClass('closed');
        }

        $(container).removeClass('open');
        $('.sub .nav li.active').removeClass('active');

        $(target).parents('li').addClass('active');



        $('#more > div.active').removeClass('active in').hide();
        $(item).fadeIn().addClass('active in');
        $(item).prevAll('.col-md-6').hide();

        morePanels.setHash(hash);

        return false;
    },
    setHash: function (hash) {
        if (hash != undefined) hash = hash.replace(/ /g, "_");

        if (window.history.replaceState) {
            window.history.replaceState({}, 'hash', '#' + hash)
        } else {
            window.location.hash = hash;
        }

        return false;
    },
    checkHash: function () {
        var hash = window.location.hash.split('#')[1];
        if (hash != undefined) hash = hash.replace(/_/g, " ").toLowerCase();

        var links = $('.sub .nav li a');
        var i = 0;

        for (i; i < links.length; i++) {
            var link = links[i];

            if (hash === $(link).attr('title').toLowerCase()) {
                morePanels.navigate($(link));
            }
        }

        return false;

    }
};

//slider controls
var simpleSlider = {
    init: function () {
        //find each slider
        var sliders = $('.slider');
        var items = sliders.find('.item');
        var ilen = items.length;
        var iwidth = $(items[0]).outerWidth(true);
        var fullwidth = ilen * iwidth + 250;
        //set it to 400% - seems to work better
        sliders.css({ 'width': fullwidth });

        //add swipe listeners
        $('.people-list.stacked')[0].addEventListener('touchstart', simpleSlider.touchStartHandler, true);
        $('.people-list.stacked')[0].addEventListener('touchend', simpleSlider.touchEndHandler, true);
    },

    slide: function (e) {
        //find direction of slide by classnames
        var dir = $(this).attr('class');
        //find slide increment by subtracting the item width
        //from the slider width - this keeps things looking even
        var item = $(this).parent().parent().find('.item')[0];
        var slider = $(this).parent().parent();
        var inc = $(item).outerWidth(true);

        if (dir === 'prev') {
            simpleSlider.go(inc, e);
        } else {
            simpleSlider.go(inc * -1, e);
        };
    },

    go: function (inc, e) {
        var slider = $(e.target.parentElement.parentElement.parentElement).find('.slider');
        var item = slider.find('.item');
        var curPos = parseInt(slider.css('left'));
        var newpos = curPos + inc;
        var min = $(item[0]).outerWidth();
        var max = min * item.length - min;

        if (inc > min) { //previous was clicked
            if (curPos >= 0) {
                return false;
            } else {
                slider.css({ 'left': newpos });
            };
        } else if (inc < min) { //next was clicked
            if (curPos <= max * -1) {
                return false;
            } else {
                slider.css({ 'left': newpos });
            }
        };

    },

    touchesInAction: {},

    touchStartHandler: function (e) {
        var touches = e.changedTouches;
        var j = 0;

        for (j; j < touches.length; j++) {
            simpleSlider.touchesInAction[touches[j].identifier] = {
                indentifier: touches[j].identifier,
                pageY: touches[j].pageY
            };
        }
    },

    touchEndHandler: function (e) {
        var touches = e.changedTouches;
        var j = 0;
        var yDelta;

        for (j; j < touches.length; j++) {
            var theTouchInfo = simpleSlider.touchesInAction[touches[j].identifier];
            yDelta = touches[j].pageY - theTouchInfo.pageY;
        }

        //trigger clicks in dom
        //TODO reconfigure to just call go with the direction
        if (yDelta > 0) {
            $('.people-list.stacked .controls li.prev').click();

        } else if (yDelta < 0) {
            $('.people-list.stacked .controls li.next').click();

        } else {
            //            simpleSlider.touchesInAction = {};

            return false;
        };

        //reset the touches object for easy reuse
        //        simpleSlider.touchesInAction = {};
    }

};

//pauses the slider for video
//may break out slider controls
//so sliders can be stopped just
//by using sliderControl.stop()
var sliderControl = {
    //init sets the height of the video to that of its container
    init: function (video) {
        if (video === null) return false;
        //find other item div heights
        var slider = $(video).parents('.carousel-inner');
        var images = slider.find('img');
        var ilen = images.length;
        var iheights = [];
        var i = 0;
        var n;

        for (i; i < ilen; i++) {
            //if image has height - add it to the height array
            if ((images[i] != undefined) || (images[i].offsetWidth != 0)) {
                iheights.push(images[i].offsetHeight);

            };
        }

        iheights.sort();


        n = iheights[iheights.length - 1];

        if (n === 0) return false;

        video.css({ 'max-height': n, 'height': n, 'width': 'auto', 'margin': 'auto' });
    },

    //checks if there is a video on the current slide
    checkSlide: function (e) {
        var playingVideos = $('.carousel').find('video');
        //first stop all playing videos and return to zero
        playingVideos.each(function () {
            $(this)[0].pause();
            $(this)[0].currentTime = 0;
        });

        //find this slide's video
        var video = $(e.relatedTarget).find('video')[0];
        if (!video) return false;

        //pause the slider - play the video
        //on video play complete restart slideshow
        //and set video back to zero for replay
        $('.carousel').carousel('pause');
        var t = video.duration / 1000 + 1000;

        video.play();

        //listen to end of video and then restart
        $(video).on('ended', function () {
            $('.carousel').carousel('cycle');
            video.currentTime = 0;
            video.pause();
        });
    }

};
function heightCheck(boxes) {
    $(boxes).each(function () {
        var box = $(this);
        var bClass = $(this).attr('class');
        var bId = $(this).attr('id');
        var bg = bClass.indexOf('-bg');
        var sm = bClass.indexOf('small');
        var pr = -1;

        if (bId != undefined) var pr = bId.indexOf('practices');


        if (
			(box.height() === 0) ||
			(bg != -1) ||
			(pr != -1) && (sm != -1) ||
			(sm != -1)
		) {
            var h = box[0].offsetWidth;
            if (h === 0) h = box.prev().height();
            box[0].style.cssText = "height:" + h + "px!important";

        }
    });
}
function gapFix() {
    var boxes = $('.mosaic').find('.tile');

    if (document.documentElement.offsetWidth <= 768) {
        heightCheck(boxes);
        return false;

    }
    if ($('.mosaic').length <= 0) return false;

    //get all half width tiles
    var tiles = $('.mosaic .outer');
    //run cleanup here so you have the tiles
    cleanUp();

    //if outer tiles are over half the page
    //they have stacked and we do not need to
    //fix so we return out
    if (tiles[1]) {
        if (tiles[1].offsetWidth > document.documentElement.offsetWidth * 0.51) return false;

    }

    var heights = [];
    var tlen = tiles.length;
    var i = j = 0;
    var x = 1; //starting x at 1 to avoid having to skip first height on sort
    var images = $('.mosaic').find('img');
    var imglen = images.length;
    var loadedlen = 0;
    var image;

    //checker checks if one image is loaded
    //if it is it checks if all are loaded
    //if all are loaded it runs the fixer
    function checker(event) {
        image = $(this);
        if ($(this)[0].complete) {
            loadedlen++;
            check();
        } else {
            $(this)[0].onload = function () {
                loadedlen++;

                check();
            };
        };

        function check() {
            if (loadedlen === imglen) {
                heightCheck(boxes);



                run();
            }
        }
    }


    function run() {
        var isLeft = false;
        var isRight = false;

        //fix CTA height
        $('.mosaic .tile.cta').css({ 'height': $('.mosaic .tile.cta').prev().height() });
        //		$('.mosaic .tile#practices').css({ 'height' : $('.mosaic .tile#practices').next().height() });
        //put heights in array
        for (i; i < tlen; i++) {
            heights.push($(tiles[i])[0].offsetHeight);
        }
        //compare heights and find which is taller (should only be two values)
        var hlen = heights.length;
        var shorty;

        //set height of column
        for (x; x < hlen; x++) {
            if (heights[x] < heights[x - 1]) {
                //get shorter tile and apply height from taller
                shorty = $(tiles[x]);
                shorty.css({ 'min-height': heights[x - 1] }).addClass('fixed');
                isRight = true;
            } else if (heights[x] > heights[x - 1]) {
                shorty = $(tiles[x - 1]);
                //note here the taller height is the last one
                shorty.css({ 'min-height': heights[x] }).addClass('fixed');
                isLeft = true;
            } else {
                isLeft = isRight = false;
                return false;

            }
        };

        //find last container in column and make it stretch down to bottom of parent
        var stiles = shorty.find('.tile');
        var sheights = [];
        var stlen = stiles.length;
        var lasttile = stiles[stlen - 1];
        var lasttwotiles = [];

        //look for a wide tile to add height too
        //if not use the last tile in the column
        stiles.each(function () {
            var that = $(this);
            var sarray = that.attr('class').split(' ');
            var wideindex = sarray.indexOf('col-md-12');
            var smallindex = sarray.indexOf('col-md-6')
            var smallrowindex = sarray.indexOf('small');
            var medindex = sarray.indexOf('med');
            var tallindex = sarray.indexOf('tall');
            var ctaindex = sarray.indexOf('cta');

            if (wideindex != -1) {
                lasttile = that;
                //                lastheight = jQuery(lasttile).height();
            }

            if (smallindex >= 0) {
                //                stlen = smallindex-stlen;
            }

            //if there are two small tiles
            //stretch them both down
            if (smallrowindex != -1) {
                lasttwotiles.push(that);

            }

            if (medindex != -1) {
                lasttile = that;

            }
        });

        var lastheight = $(lasttile).outerHeight();
        var z = 0;

        //look at all their heights and add them up
        //then subtract from the taller height
        //then add back to original height to match
        for (z; z < stlen; z++) {
            sheights.push($(stiles[z]).outerHeight());
        }

        var sheightslen = sheights.length;
        var s = 0;
        var totalHeight = 0;
        var sheight = shorty.height();

        for (s; s < sheightslen; s++) {
            totalHeight += parseInt(sheights[s]);
        }

        var lt = 0;
        //set height on either wide div
        //        if( totalHeight < sheight ) {
        //increase last tiles height to fill in parent
        if (isLeft && lasttwotiles.length <= 1) {
            var newheight = sheight - totalHeight;
        } else if (isLeft && lasttwotiles.length > 1) {
            var newheight = sheight - lastheight;
        } else {
            //				var newheight = sheights[0] + (sheight - lastheight);
            var newheight = sheight - totalHeight + lastheight;

        }

        //if there are two tiles at the bottom of the div
        //apply height to both
        //if not do it to the last tile only
        if (lasttwotiles.length > 1) {
            for (lt; lt < lasttwotiles.length; lt++) {
                lasttwotiles[lt][0].style.cssText = 'height : ' + newheight + 'px!important; min-height :' + newheight + 'px!important; max-height ' + newheight + 'px!important;';

            }
        } else {
            lasttile[0].style.cssText = 'height : ' + newheight + 'px!important; min-height :' + newheight + 'px!important; max-height ' + newheight + 'px!important;';
            $(lasttile).addClass('fixed');



        }
        //        }
    }

    function cleanUp() {
        //if on mobile or there isnt a mosaic get out
        if (document.documentElement.offsetWidth < 992) {
            //clear styles
            $('.fixed').css({ 'min-height': '', 'height': '', 'max-heigth': '' });


        };
    }

    //cycles through all images on the page
    //and fires checker on them
    $(images).each(checker);
}

function searchExpander() {
    var formCont = $('nav .search');
    var form = $('nav .search .form');
    var stateA = $('nav .search .form').attr('class').split(" ");
    var state = stateA[stateA.length - 1];

    //pretty self explanitory - adds/removes open class to search
    //open class contains css to move it into position
    //use animated-* styles to animate
    if (state === 'open') {
        formCont.removeClass('open');
        form.removeClass('open');
    } else {
        formCont.addClass('open');
        form.addClass('open');
    };
}

function ratioResize() {
    var tile = $('.mosaic .tile');

    $(tile).each(function () {
        var thisTile = $(this);
        var img = $(thisTile).find('.background');

        if ($(img).attr('class') != undefined) {
            var tHeight = $(thisTile).height();
            var height = $(img).height();
            var width = $(img).width();

            //			if( height > tHeight ) {
            //				height = (height / width) * tHeight;
            
            //				$(img).css({ 'height' : height });

            //			} else {
            $(thisTile).css({ 'height': height });

            //			}


        }
    });
}

var resizeTime = null;
$(window).on('resize', function () {
    //wait until done resizing
    clearTimeout(resizeTime);
    resizeTime = setTimeout(function () {
        //		if((orientationTimer === null) || (orientationTimer === undefined)) gapFix();

		if ( ($('#more').length > 0) && (vpw >= 768) ) {
	        $('#more').each(function () {
	            morePanels.init($(this));
	        });
        }


        video = $('.carousel-inner').find('video');

        if (video.length >= 0) {
            sliderControl.init(video);
        }


        if ($('.people-list.stacked').length > 0) {


            $('#peopleSlider').lemmonSlider({
                'infinite': true,
                'slideToLast': true
            });
        }

//        if ($('[data-expander]').length > 0) expander.resize($('[data-expander]')[0]);

		if ($('[data-expander]').length > 0) $('[data-expander]')[0].expandMe();
		
        var video = $('.carousel-inner').find('video');

        sliderControl.init(video);

        if ( ($('.matchThis').length >= 0) && (vpw >= 768 ) ) {
            $('.matchThis').each(function () {
                $(this)[0].matchHeight();
            });
        }
        
		if ($('.people-list.stacked').length >= 0) {
			lemmonInit();
		};
    }, 250);
    
});


Array.prototype.copyMe = function () {
    return this;
}
  
$( document ).ready(function() {  


  setTimeout(function () {
        // $('.img-jumbo').animate({ 'min-height': '' });
        $('.img-jumbo').css('min-height', 'initial'); 
        $('.carousel-caption').fadeIn('fast');
        $('nav.sub, aside#more, section.mosaic, section.people-list.row, footer').fadeIn('fast');
    }, 100);
    
  if (vpw > 769 )  {  
      $(".dropdown-menu.two-tier li").on("mouseover touchstart touchmove click", function() {
        $(this).parents(".dropdown").addClass('delayedhovered');
        $(".dropdown-menu.two-tier li").removeClass('hovered permahover');
        $(this).addClass('hovered permahover');
          if (($(".site-nav .nav > .dropdown:not(.ignore)").hasClass("hovered")) && (vpw > 1024 ) ) {
              $('#nav-overlay').addClass('second-dark');
            }
      });
      $(".dropdown-menu.two-tier li").on("mouseleave", function() {
         var $hidex = $(this).parents(".dropdown").addClass('delayedhovered');
              setTimeout(function () {
                  $hidex.removeClass('delayedhovered');
              }, 1500); 
      });
      $("#nav-overlay").on("click touchstart ", function() {
          $('#nav-overlay').removeClass('second-dark');
      });
    }
  if (vpw <= 768 )  {
       $('#more div:first-of-type').removeClass('active');
       $('#p_lt_ctl00_WebPartZone1_WebPartZone1_zone_ManattSmartSearchBox_pnlPredictiveResultsHolder').hide();

    $('#more .collapse').on('shown.bs.collapse', function (e) {
        var top = $('a.btn.expander.black-bg.hidden-md.hidden-lg[aria-expanded=true]').offset().top;
        $('body').animate({
                scrollTop: top
            }, 400);
    });

       
  }
    
    
    $( window ).resize(function() {
        var currentWidth = $( window ).width();    
        //console.log(currentWidth);
        if(currentWidth <= 768 ){
            $('#p_lt_ctl00_WebPartZone1_WebPartZone1_zone_ManattSmartSearchBox_pnlPredictiveResultsHolder').hide();
        }  
        else{
            
            initSearch();
            
        }
    });

    // when panel clicks careers - staff, scroll to top #accordion3
    $('#careers #accordion3 .panel a').click(function(event) {
        // event.preventDefault();
        $('html, body').animate({
            scrollTop: $('#accordion3').offset().top
        }, 300);
    })

});
