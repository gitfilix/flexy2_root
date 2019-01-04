jQuery.fn.extend({
  slideRightShow: function() {
    return this.each(function() {
        $(this).show('slide', {direction: 'right'}, 1000);
    });
  },
  slideLeftHide: function() {
    return this.each(function() {
      $(this).hide('slide', {direction: 'left'}, 1000);
    });
  },
  slideRightHide: function() {
    return this.each(function() {
      $(this).hide('slide', {direction: 'right'}, 1000);
    });
  },
  slideLeftShow: function() {
    return this.each(function() {
      $(this).show('slide', {direction: 'left'}, 1000);
    });
  }
});

(function ($) {
// VERTICALLY ALIGN FUNCTION
$.fn.vAlign = function() {
  return this.each(function(i){
  var ah = $(this).height();
  var ph = $(this).parent().parent().height();
  var mh = (ph - ah) / 2;
  if(mh>0) {
    $(this).css('margin-top', mh);
  } else {
    $(this).css('margin-top', 0);
  }
});
};
})(jQuery);

function showOverlay(x){
	$('.overlay').slideUp();
	if($('#'+x).css('display')=='block'){
		$('#'+x).slideUp();	
	}
	else{
		closeLeftNav()
		$('#'+x).slideToggle();
			
	}
}

function showInfoWindow(str){
	$('.infowindow').css({
		top: (($(window).height() / 2) - ($('.infowindow').height() / 2)),
		left: ($(window).width() / 2) - 160,
		width:280,
		color: 'white',
		fontSize: 24,
		padding: '20px',
		position: 'absolute',
		backgroundColor: 'red'
	}).html(str + '<div style="position:absolute;right:10px;top:10px;" onclick="hideInfoWindow();" style="cursor:pointer;">x</div>').fadeIn();
}

function hideInfoWindow(){
	$('.infowindow').fadeOut();
}

function toggleLeftNav(){
	hideInfoWindow()
	if(parseInt($('#offcanvas').css('left'))==0){
		$('#offcanvas').animate({
			left:-320
		},200);
	}
	else{
		$('#offcanvas').animate({
			left:0
		},100)
		$('.overlay').hide();	
	}	
}

function closeLeftNav(){
	$('#offcanvas').animate({
		left:-320
	},200);
}

function toggleTopMenu(){
	hideInfoWindow()
	if(parseInt($('#navigBar').css('transform').split(',')[5])=='-50'){
		$('#navigBar').css({
			transition: 'all 0.2s',
			transform: 'translateY(0)'
		});
		
		$('.footer').css({
			transition: 'all 0.2s',
			transform: 'translateY(0)'
		});
	}
	else{
		closeLeftNav();
		closeTopMenu();		
	}
}

function closeTopMenu(){
	$('.overlay').fadeOut(500,function(){
		$('#navigBar').css({
			transition: 'all 0.2s',
			transform: 'translateY(-50px)'
		});	
		$('.footer').css({
			transition: 'all 0.2s',
			transform: 'translateY(50px)'
		});
	});		
}

function showTopMenu(){
	$('#navigBar').css({
		transition: 'all 0.2s',
		transform: 'translateY(0px)'
	});
	$('.footer').css({
		transition: 'all 0.2s',
		transform: 'translateY(0)'
	});
}

function closeLightbox(){	
	$('#lightbox').fadeOut(500,function(){
		$('#lightbox>div').empty();		
	});
}

function keyHandlers(e){
	 hideInfoWindow();
	 closeTopMenu();
	 $('.overlay').hide();	
	 closeLeftNav()
	  switch (e.keyCode) {
		case 13: // ENTER. ESC should also take you out of fullscreen by default.
		  e.preventDefault();
		  document.cancelFullScreen(); // explicitly go out of fs.
		  break;
		case 70: // f
		  enterFullscreen();
		  break;
	  }	
}

function detachKeyEvents(){
	document.removeEventListener ('keydown',keyHandlers,false);
}

document.cancelFullScreen = document.webkitExitFullscreen || document.mozCancelFullScreen || document.exitFullscreen;
var elem = document.querySelector(document.webkitExitFullscreen ? "#fs" : "#fs-container");

document.addEventListener('keydown', function(e) {
	keyHandlers(e)
}, false);

function toggleFS(el) {
  if (el.webkitEnterFullScreen) {
    el.webkitEnterFullScreen();
  } else {
    if (el.mozRequestFullScreen) {
      el.mozRequestFullScreen();
    } else {
      el.requestFullscreen();
    }
  }

  el.ondblclick = exitFullscreen;
}

function onFullScreenEnter() {
  console.log("Entered fullscreen!");
  elem.onwebkitfullscreenchange = onFullScreenExit;
  elem.onmozfullscreenchange = onFullScreenExit;
};

// Called whenever the browser exits fullscreen.
function onFullScreenExit() {
  console.log("Exited fullscreen!");
};

// Note: FF nightly needs about:config full-screen-api.enabled set to true.
function enterFullscreen() {
  console.log("enterFullscreen()");
  elem.onwebkitfullscreenchange = onFullScreenEnter;
  elem.onmozfullscreenchange = onFullScreenEnter;
  elem.onfullscreenchange = onFullScreenEnter;
  if (elem.webkitRequestFullscreen) {
    elem.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
  } else {
    if (elem.mozRequestFullScreen) {
      elem.mozRequestFullScreen();
    } else {
      elem.requestFullscreen();
    }
  }
  //document.getElementById('enter-exit-fs').onclick = exitFullscreen;
}

function exitFullscreen() {
  console.log("exitFullscreen()");
  document.cancelFullScreen();
  //document.getElementById('enter-exit-fs').onclick = enterFullscreen;
}


function loadAndInjectPage(SectionID,idx){	
	// get ajax-url to load
	f = $('.ft-page','.ft-section[data-prog="'+SectionID+'"]').get(idx-1);
	ajaxURL = $(f).data('ajaxcontent')
	$.get('ajax/'+ajaxURL,{},function(data){
		x = $('.ft-page','.ft-section[data-prog="'+SectionID+'"]').get(idx-1);
		$(x).html(data)
		initSlide(SectionID,idx);
		console.log(1)
	});	
}

var myScroll;
function loaded() {
	myScroll = new IScroll('#wrapper221', { scrollX: true, scrollY: false, mouseWheel: true });
}

function initFitText(section,page){
	targetPage = $('.ft-page','.ft-section[data-prog="'+section+'"]').get(page-1);
	jQuery("div",$(targetPage)).fitText(1.45);
	jQuery(".slides div h1",$(targetPage)).fitText();
	jQuery(".centered header h1",$(targetPage)).fitText(1.2);
	jQuery(".centered header h2",$(targetPage)).fitText(0.9);
	jQuery(".back",$(targetPage)).fitText(1.6);
	jQuery("#lightbox").fitText(10.8);		
}

function initLightbox(section,page){
	targetPage = $('.ft-page','.ft-section[data-prog="'+section+'"]').get(page-1);
	$('.lightbox',$(targetPage)).css('cursor','pointer').click(function(e){			
		e.preventDefault();
		cnt = $(this).data('lightboxdiv');
		type = $(this).data('lightboxtype');
		html = $('#'+cnt).html();
		$('#lightbox > div').html(html);
		$('#lightbox').attr('class','');
		$('#lightbox').addClass(type);
		$('#lightbox').fadeIn();
		$('.flexslider','#lightbox').flexslider({
			controlNav: true, 
			directionNav: true,
			slideshow: false,
			smoothHeight: false,
			prevText: "zurück",
			nextText: "weiter"
		});
		$('.flexslider','#lightbox').on('keyup touchmove touchend', function(e){
			e.preventDefault()	
		});
	});	
}

function initFlip(section,page){
	targetPage = $('.ft-page','.ft-section[data-prog="'+section+'"]').get(page-1);
	$('.flip',$(targetPage)).click(function(){
		
		if($('.flipper',$(this)).css('transform')=='matrix3d(-1, 0, 0, 0, 0, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1' || $('.flipper',$(this)).css('transform')=='none' || $('.flipper',$(this)).css('transform')=='matrix(1, 0, 0, 1, 0, 0)'){
			$('.flip-container:hover .flipper, .flip-container.hover .flipper',$(this)).css({
				transform: 'rotateY(180deg)',
				mozTransform: 'rotateY(180deg)',
				webkitTransform: 'rotateY(180deg)'					
			});	
		}
		else{
			$('.flip-container .flipper',$(this)).css({
				transform: 'rotateY(0deg)',
				mozTransform: 'rotateY(0deg)',
				webkitTransform: 'rotateY(0deg)'					
			});	
		}					
	});	
}

function initFlexSlider(section,page,type){
	// type = 1: full-width, 2: multi-elements
	targetPage = $('.ft-page','.ft-section[data-prog="'+section+'"]').get(page-1);
	
	minItems = 1
	maxItems = 1
	move = 1
	animation = 'fade'	
	itemWidth = '100%'
	itemMargin = 0
	
	if(type==2){
		minItems = 4
		maxItems = 8
		move = 2
		animation = 'slide'	
		itemWidth = '240'
		itemMargin = 20
	}
	
	$('.flexslider',$(targetPage)).flexslider({
		controlNav: false, 
		directionNav: false,
		itemWidth: itemWidth,
		itemMargin: itemMargin,
		minItems: minItems,
		maxItems: maxItems,
		move: move ,
		animation: "slide",
		animationLoop: false
	});
}

function initSlide(section,page){
	targetPage = $('.ft-page','.ft-section[data-prog="'+section+'"]').get(page-1);
	
	if($(window).width() > 800){
		bg = $(targetPage).data('background')	
	}
	else{
		bg = $(targetPage).data('backgroundsmall')	
	}
	if(bg!=''){
		$(targetPage).css({
			'background': 'transparent url("../upload/magazine/' + bg + '") center center no-repeat',
			'background-size': 'cover' 
		})
	}
	
	initFlexSlider(section,page,2);
	initFlip(section,page)
	initLightbox(section,page)
	//initFitText(section,page)
	
	if($(window).width()>600){
		d = Flowtime.getPage();	
		
		/*$('.anim',d).each(function(idx){
			delay = $(this).data('inanimation').split('-')[0];
			anim = $(this).data('inanimation').split('-')[1];
			zeit = $(this).data('inanimation').split('-')[2];
			css = $(this).data('style');
			
			newCss = 'animation:' + anim + ' ' + zeit+'s;animation-delay: '+delay+'s;'+css
			$(this).attr('style',newCss);
			$('.anim',d).removeClass('hidden');
		});*/
	}
	
}

/*function init(){
	
	$('.flexslider').flexslider({
		controlNav: false, 
		directionNav: false,
		itemWidth: 240, 
		itemMargin: 20,
		minItems: 4,
		maxItems: 8,
		move: 2 ,
		animation: "slide",
		animationLoop: false
	});
	
	$('.flip').click(function(){
		
		if($('.flipper',$(this)).css('transform')=='matrix3d(-1, 0, 0, 0, 0, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1' || $('.flipper',$(this)).css('transform')=='none' || $('.flipper',$(this)).css('transform')=='matrix(1, 0, 0, 1, 0, 0)'){
			$('.flip-container:hover .flipper, .flip-container.hover .flipper').css({
				transform: 'rotateY(180deg)',
				mozTransform: 'rotateY(180deg)',
				webkitTransform: 'rotateY(180deg)'					
			});	
		}
		else{
			$('.flip-container .flipper').css({
				transform: 'rotateY(0deg)',
				mozTransform: 'rotateY(0deg)',
				webkitTransform: 'rotateY(0deg)'					
			});	
		}					
	});
				
	$('.lightbox').css('cursor','pointer').click(function(e){			
		e.preventDefault();
		cnt = $(this).data('lightboxdiv');
		type = $(this).data('lightboxtype');
		html = $('#'+cnt).html();
		$('#lightbox > div').html(html);
		$('#lightbox').attr('class','');
		$('#lightbox').addClass(type);
		$('#lightbox').fadeIn();
		$('.flexslider').flexslider({
			controlNav: true, 
			directionNav: true,
			slideshow: false,
			smoothHeight: false,
			prevText: "zurück",
			nextText: "weiter"
		});

		$('.flexslider, #lightbox,.overflow').on('keyup touchmove touchend', function(e){
			e.preventDefault()	
		});
		
	});
	
	jQuery(".ft-page > div").fitText(1.45);
	jQuery(".slides div h1").fitText();
	jQuery(".centered header h1").fitText(1.2);
	jQuery(".centered header h2").fitText(0.9);
	jQuery(".back").fitText(1.6);
	jQuery("#lightbox").fitText(10.8);	
	
	if($(window).width()>600){
		d = Flowtime.getPage();	
		$('.anim').removeAttr('style');
		$('.anim',d).each(function(idx){
			delay = $(this).data('inanimation').split('-')[0];
			anim = $(this).data('inanimation').split('-')[1];
			zeit = $(this).data('inanimation').split('-')[2];
			css = $(this).data('style');
			
			newCss = 'animation:' + anim + ' ' + zeit+'s;animation-delay: '+delay+'s;'+css
			$(this).attr('style',newCss);
		});
	}
	
	$('.overflow').on('touchmove', function(e){
		e.stopPropagation()	
	});
	
	$('.flexslider, #lightbox, .iscroll').on('keyup touchmove touchend', function(e){
		e.preventDefault()	
	});

}*/

var cacheTitle = document.title.replace("travelMag | ", "");
var _gaq = _gaq || [];
_gaq.push(['_setAccount', '']);
_gaq.push(['_trackPageview']);
_gaq.push(['_trackEvent', 'Flowtime', 'Landing', document.title]);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

// Configuration API test
Flowtime.showProgress(true);
// Flowtime.fragmentsOnSide(true);
// Flowtime.fragmentsOnBack(true);
// Flowtime.useHistory(false);
// Flowtime.slideInPx(true);
// Flowtime.sectionsSlideToTop(true);
Flowtime.gridNavigation(false);
Flowtime.useOverviewVariant(true);
Flowtime.parallaxInPx(true);
Flowtime.loop(true);
Flowtime.mouseDragEnabled(true);
//Flowtime.autoplay(true, 1000, true, false);
//
// event management
Flowtime.addEventListener("flowtimenavigation", onNavigation, false);
function onNavigation(e)
{
	hashSection = '__1'
	hashPage = 1
	if(window.location.hash!=''){
		hashSection = '__'+window.location.hash.replace('#/','').split('/')[0].split('-')[1]
		if(window.location.hash.split('/').length>2){
			hashPage = window.location.hash.replace('#/','').split('/')[1].split('-')[1]
			if(hashSection!='__1'){
				$('.ft-page','.ft-section[data-prog="'+hashSection+'"]').each(function(idx){
					loadAndInjectPage(hashSection,idx+1)
				})
				$('.ft-page','.ft-section[data-prog="'+(hashSection-1)+'"]').each(function(idx){
					loadAndInjectPage((hashSection-1),idx+1)
				})
				$('.ft-page','.ft-section[data-prog="'+(hashSection+1)+'"]').each(function(idx){
					loadAndInjectPage((hashSection+1),idx+1)
				})
			}
		}
		else{
			if(hashSection!='__1'){
				$('.ft-page','.ft-section[data-prog="'+(hashSection)+'"]').each(function(idx){
					loadAndInjectPage(hashSection,idx+1)
				})
			}
		}
	}
	
	
	
	_gaq.push(['_trackEvent', 'Flowtime', 'Navigation', cacheTitle + ' > ' + document.title.replace("travelMag | ", "")]);
	cacheTitle = document.title.replace("travelMag | ", "");

	isHome = true;
	dirH = '';
	dirV = '';
	
	x = $('.ft-page').get(e.pageIndex)
	allowed = $(x).data('alloweddirections').split(',');
	allowedTop = allowed[0];
	allowedRight = allowed[1];
	allowedBottom = allowed[2];
	allowedLeft = allowed[3];

	if(e.sectionIndex!=0 || e.pageIndex!=0){
		isHome = false;
	}
	if(e.pastSectionIndex < e.sectionIndex){
		dirH = 'right';
	}
	else if(e.pastSectionIndex > e.sectionIndex){
		dirH = 'left'	
	}
	if(e.pastPageIndex < e.pageIndex){
		dirV = 'down'	
	}
	else if(e.pastPageIndex > e.pageIndex){
		dirV = 'up'	
	}
		
	// load next pages; clear dom
	actSection = e.sectionIndex;
	actPage = e.pageIndex;	
	actSectionObj = $('.ft-section').get(actSection);
	actSectionID = $(actSectionObj).data('prog')
	if(e.nextSection){
		nxtSection = e.sectionIndex+1
		nxtSectionObj = $('.ft-section').get(nxtSection);
		nxtSectionID = $(nxtSectionObj).data('prog')
		
		if($('.ft-section').get(nxtSection+1)){
			nxtNxtSection = nxtSection+1
			nxtNxtSectionObj = $('.ft-section').get(nxtNxtSection);
			nxtNxtSectionID = $(nxtNxtSectionObj).data('prog')
		}
		else{
			nxtNxtSection = 0
			nxtNxtSectionObj = $('.ft-section').get(nxtSection);
			nxtNxtSectionID = $(nxtSectionObj).data('prog')
		}	
		
	}
	else{
		nxtSection = 0
		nxtSectionObj = $('.ft-section').get(nxtSection);
		nxtSectionID = $(nxtSectionObj).data('prog')
		
		nxtNxtSection = 0
		nxtNxtSectionObj = $('.ft-section').get(nxtNxtSection);
		nxtNxtSectionID = $(nxtNxtSectionObj).data('prog')
	}	
	if(e.prevSection){
		prvSection = e.sectionIndex-1
		prvSectionObj = $('.ft-section').get(prvSection);
		prvSectionID = $(prvSectionObj).data('prog')
		
		if($('.ft-section').get(prvSection-1)){
			prvPrvSection = prvSection-1
			prvPrvSectionObj = $('.ft-section').get(prvPrvSection);
			prvPrvSectionID = $(prvPrvSectionObj).data('prog')
		}
		else{
			prvPrvSection = 0
			prvPrvSectionObj = $('.ft-section').get(prvPrvSection);
			prvPrvSectionID = $(prvPrvSectionObj).data('prog')
		}	
		
	}
	else{
		prvSection = $('.ft-section').length-1;
		prvSectionObj = $('.ft-section').get(prvSection);
		prvSectionID = $(prvSectionObj).data('prog')
		
		prvPrvSection = $('.ft-section').length-1;
		prvPrvSectionObj = $('.ft-section').get(prvPrvSection);
		prvPrvSectionID = $(prvPrvSectionObj).data('prog')
	}	
	
	if(isHome){	
		// home laden
		$('.ft-page','.ft-section[data-prog="'+actSectionID+'"]').each(function(idx){
			loadAndInjectPage(actSectionID,idx+1)
			//console.log(actSectionID)
		})
		// nächstes kapitel laden
		$('.ft-page','.ft-section[data-prog="'+nxtSectionID+'"]').each(function(idxx){
			loadAndInjectPage(nxtSectionID,idxx+1)
			//console.log(nxtSectionID)
		});
		//voriges kapitel laden
		$('.ft-page','.ft-section[data-prog="'+prvSectionID+'"]').each(function(idxx){
			loadAndInjectPage(prvSectionID,idxx+1)
			//console.log(prvSectionID)
		});
		/*$('.ft-page','.ft-section[data-prog="__'+$('.ft-section').length-1+'"]').each(function(idxx){
			loadAndInjectPage('__'+$('.ft-section').length-1,idxx+1)
			//loadAndInjectPage('__'+($('.ft-section').length-1),idxx+1)
		})*/
	}
	
	
	
	if(dirH=='right'){
		$('.ft-page','.ft-section[data-prog="'+nxtNxtSectionID+'"]').each(function(idxxx){
			loadAndInjectPage(nxtNxtSectionID,idxxx+1)
		})
		console.log(nxtSectionID)
	}
	else if(dirH=='right' && e.progress == e.total){
		$('.ft-page','.ft-section[data-prog="__1"]').each(function(idxxx){
			loadAndInjectPage('__1',idxxx+1)
		})
	}
	
	if(dirH=='left' && !isHome){
		$('.ft-page','.ft-section[data-prog="'+prvPrvSectionID+'"]').each(function(idx){
			loadAndInjectPage(prvPrvSectionID,idx+1)
		})	
	}
	
	// clean DOM
	$('.ft-section').each(function(){
		if($(this).data('prog')!=prvSectionID && $(this).data('prog')!=actSectionID && $(this).data('prog')!=nxtSectionID){
			$('.ft-page',this).empty();	
			$('.ft-page',this).css('background','none');	
			//set ajax-loader
			wdt = parseInt($(window).height() / 2)
			$('.ft-page',this).html('<div style="height:100%;text-align:center;background-color:#333;opacity:0.8;"><img src="img/popup_ajax_loader.gif" style="margin-top:' + wdt + 'px;" /></div>');
		}	
	})
	
	/*if($(window).width()>600){
		d = Flowtime.getPage();	
		
		$('.anim',d).each(function(idx){
			delay = $(this).data('inanimation').split('-')[0];
			anim = $(this).data('inanimation').split('-')[1];
			zeit = $(this).data('inanimation').split('-')[2];
			css = $(this).data('style');
			
			newCss = 'animation:' + anim + ' ' + zeit+'s;animation-delay: '+delay+'s;'+css
			$(this).attr('style',newCss);
			$('.anim',d).removeClass('hidden');
		});
	}*/

}
// starts the application with configuration options
Flowtime.start();

$(document).ready(function(){
	$('#rotate div').vAlign();
	$('.ft-page').each(function(){
		wdt = parseInt($(window).height() / 2)
		$('.ft-page').html('<div style="height:100%;text-align:center;background-color:#333;opacity:0.8;"><img src="img/popup_ajax_loader.gif" style="margin-top:' + wdt + 'px;" /></div>');
	});
	$('#menuhandle').click(function(e){
		toggleTopMenu();	
	});
	
	
	
});

$(document).bind('touchmove',function(e){
	 e.preventDefault();
	 hideInfoWindow();
	 closeTopMenu();
	 $('.overlay').hide();	
	 closeLeftNav()
	
});



window.addEventListener("load",function() {
	// Set a timeout...
	setTimeout(function(){
		// Hide the address bar!
		window.scrollTo(0, 1);
	}, 0);
});