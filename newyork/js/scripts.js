// VERTICALLY ALIGN FUNCTION
(function ($) {
	$.fn.vAlign = function() {
		return this.each(function(i){
			var ah = $(this).height();
			var ph = $(this).parent().height();
			var mh = (ph - ah) / 2;
			if(mh>0) {
				$(this).css('padding-top', mh);
			} else {
				$(this).css('padding-top', 0);
			}
		});
	};
})(jQuery);

// check for css vendor-prefix
if (Modernizr.csstransforms3d) {
	var trans_key = Modernizr.prefixed('transform').replace(/([A-Z])/g, function(str,m1){ return '-' + m1.toLowerCase(); }).replace(/^ms-/,'-ms-');

} else if (Modernizr.csstransforms) {
	var trans_key = Modernizr.prefixed('transform').replace(/([A-Z])/g, function(str,m1){ return '-' + m1.toLowerCase(); }).replace(/^ms-/,'-ms-');
}

var slidey
var inAnim = new Array();
var outanim = new Array();
var repeat = true
var map

function initAnimations(){
	// clear previously set timeouts when returning to slide
	clearAnimTimeouts()
	
	// prepeare animations
	$('.anim').stop(true).css({opacity:0});
	// execute custom animation on particular slide
	$('.anim',$('.activeSlide')).each(function(idx){
		// repeat: if animation should be played once or shoulkd be repeated when returning. default true
		if ($(this).attr('data-repeatanimation')) {
			repeat = $(this).attr('data-repeatanimation')
		}
		delay = $(this).data('inanimation').split('-')[0];
		anim = $(this).data('inanimation').split('-')[1];
		zeit = $(this).data('inanimation').split('-')[2];
		if($(this).data('inanimation').split('-').length == 4){
			easing = $(this).data('inanimation').split('-')[3];	
		}
		else{
			easing = 'swing';		
		}
		zt = zeit * 1000;
		dl = delay * 1000;
		outDelay = 0
		outAnim = ''
		outZeit = 0
		outEasing = 'swing'
		ozt = 0
		odl = 0

		if ($(this).attr('data-outanimation')) {
			outDelay = $(this).data('outanimation').split('-')[0];
			outAnim = $(this).data('outanimation').split('-')[1];
			outZeit = $(this).data('outanimation').split('-')[2];
			ozt = outZeit * 1000;
			odl = outDelay * 1000;
			if($(this).data('outanimation').split('-').length == 4){
				outEasing = $(this).data('outanimation').split('-')[3];	
			}
		}

		///// in anims ////////
		if(anim != ''){
			setInAnims(idx,$(this),anim,zt,dl,easing);
			delay = 0
			anim = ''
			zeit = 0
			easing = 'linear'
			zt = 0
			dl = 0	
		}
						
		///// out anims ////////
		if(outAnim != ''){
			setOutAnims(idx,$(this),outAnim,ozt,odl,outEasing);
			outDelay = 0
			outAnim = ''
			outZeit = 0
			outEasing = 'linear'
			ozt = 0
			odl = 0	
		}
		
		if(repeat == 'false'){
			removeAnimClass($(this))
		}	
		repeat = true
	});	
}

function removeAnimClass(obj){
	$(obj).removeClass('anim')
}


function clearAnimTimeouts(){
	for (i = 0; i < inAnim.length; i++) {
		clearTimeout(inAnim[i]);
	}
	for (o = 0; o < outanim.length; o++) {
		clearTimeout(outanim[o]);
	}
	
	inAnim = []
	ouanim = []
}

function setInAnims(idx,obj,anim,zt,dl,easing){
	inAnim.push(setTimeout(function(){
		if(anim=='fadeIn'){							
			obj.show().animate({
				opacity: 1	
			},{
				duration: zt, 
				easing: easing
			})
		}
		else if(anim=="slideInRight"){
			obj.css({
				position:'absolute',
				right:-$(window).width(),
				opacity:1
			}).show().stop().animate({
				right:0	
			},{
				duration: zt, 
				easing: easing
			})
		}
		else if(anim=="slideInLeft"){
			obj.css({
				position:'absolute',
				left:-$(window).width(),
				opacity:1
			}).show().animate({
				left:0	
			},{
				duration: zt, 
				easing: easing
			})
		}
		else if(anim=="slideInTopRightDiagonal"){
			obj.css({
				position:'relative',
				right:-$(window).width(),
				top:-$(window).width(),
				opacity:1
			}).show().animate({
				right:0,
				top:0
			},{
				duration: zt, 
				easing: easing
			})
		}
		else if(anim=="slideInTop"){
		
			obj.css({
				position:'relative',
				top:-$(window).height(),
				opacity:1
			}).show().animate({
				top:0	
			},{
				duration: zt, 
				easing: easing
			})
		}
		else if(anim=="slideInBottom"){
			obj.css({
				position:'relative',
				bottom:-$(window).height(),
				opacity:1
			}).show().animate({
				bottom:0	
			},{
				duration: zt, 
				easing: easing
			})
		}
		else if(anim=="scaleTextUp"){
			oWidth = obj.width()
			oHeight = obj.height()
			obj.css({
				'-webkit-transform': 'scale(0, 0)',
				'-moz-transform': 'scale(0, 0)',
				'transform': 'scale(0, 0)',
				transition: 'none',
				'-moz-transition': 'none',
				'-webkit-transition': 'none',
				opacity:1
			})
			setTimeout(function(){
				obj.show().css({
					'-webkit-transform': 'scale('+oWidth+'px, '+oHeight+'px)',
					'-moz-transform': 'scale('+oWidth+'px, '+oHeight+'px)',
					'transform': 'scale('+oWidth+'px, '+oHeight+'px)',
					transition: 'all '+zt+'ms ease-out',
					'-moz-transition': 'all '+zt+'ms ease-out',
					'-webkit-transition': 'all '+zt+'ms ease-out'
				})
			},10)	
		}
	},dl))
	
		
}

function setOutAnims(idx,obj,outAnim,ozt,odl,outEasing){
	outanim.push(setTimeout(function(){
		if(outAnim=='fadeOut'){							
			obj.animate({
				opacity: 0
			},ozt,outEasing,function(){
				obj.remove();	
			})
		}
		else if(outAnim=="slideOutRight"){
			obj.animate({
				right:-(1.5*$(window).width()),
				left: 'auto'
			},ozt,outEasing,function(){
				obj.css({
					left:  'auto',
					right: 'auto'
				}).remove()
			})
		}
		else if(outAnim=="slideOutLeft"){
			obj.stop().animate({
				left:-(obj.width()),
				right: 'auto'
			},ozt,outEasing,function(){
				obj.css({
					right:  'auto',
					left: 'auto'
				}).remove()
			})
		}
		else if(outAnim=="slideOutTop"){
			obj.animate({
				top:-(1.5*$(window).height()),
			},ozt,outEasing,function(){
				obj.css({
					top: 'auto'
				}).hide()
			}).remove()
		}
		else if(outAnim=="slideOutBottom"){
			obj.animate({
				bottom:-(1.5*$(window).height()),
			},ozt,'swing',function(){
				obj.css({
					bottom: 'auto'
				}).remove()
			})
		}
		else if(outAnim=="scaleTextDown"){
			oWidth = obj.width()
			oHeight = obj.height()
			obj.css({
				'-webkit-transform': 'scale(0, 0)',
				'-moz-transform': 'scale(0, 0)',
				'transform': 'scale(0, 0)',
				transition: 'all '+ozt+'ms ease-out',
				'-moz-transition': 'all '+ozt+'ms ease-out'
			})
			obj.on('transitionend webkitTransitionEnd',function( event ) { 	
				$(this).css({
					'-webkit-transform': 'scale('+oWidth+'px, '+oHeight+'px)',
					'-moz-transform': 'scale('+oWidth+'px, '+oHeight+'px)',
					transition: 'none',
					opacity:0
				}).remove()
			});
		}
	},odl))	
}

function initLightbox(){
	$('.lightbox',$('.activeSlide')).not('.init').each(function(idx){
		$(this).css('cursor','pointer').addClass('init').click(function(e){		
		
			//$('#wrapper').hide();
			e.preventDefault();
			cnt = $(this).data('lightboxdiv');
			type = $(this).data('lightboxtype');
			html = $('#'+cnt).html();
			$('#lightbox > div').html(html);
			$('#lightbox').attr('class','');
			$('#lightbox').addClass(type);
			$('#lightbox').fadeIn();
			$('#lightbox').find('.ftScrollerVertical').attr('id','lighboxscrollerid')
			initFTscroller()	
			$('.center').center()
			initAnimations();
			
			/*$('.flexslider','#lightbox').flexslider({
				controlNav: true, 
				directionNav: true,
				slideshow: false,
				smoothHeight: false,
				prevText: "zurück",
				nextText: "weiter"
			});*/
			/*$('.flexslider','#lightbox').on('keyup touchmove touchend', function(e){
				e.preventDefault()	
			});*/
		
		});	
	});	
}

function closeLightbox(){	
	$('#lightbox').fadeOut(500,function(){
		$('#lightbox>div').empty();		
		$('#wrapper').show()
	});
}

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

	
	if(parseInt($('#menu').css(trans_key).split(',')[5])=='-52'){
		$('#dimmer2').show();
		$('#menu').css({
			transition: 'all 0.2s',
			'-webkit-transform': 'translateY(0)',
			'-moz-transform': 'translateY(0)',
			'transform': 'translateY(0)'
		});
		
		
		
		$('.footer').css({
			transition: 'all 0.2s',
			'-webkit-transform': 'translateY(-230px)',
			'-moz-transform': 'translateY(-230px)',
			'transform': 'translateY(-230px)'
		});
	}
	else{
		closeLeftNav();
		closeTopMenu();		
		$('#dimmer2').hide();
	}
}

function closeTopMenu(){
	$('.overlay').fadeOut(500,function(){
		$('#menu').css({
			transition: 'all 0.2s',
			'-webkit-transform': 'translateY(-52px)',
			'-moz-transform': 'translateY(-52px)',
			transform: 'translateY(-52px)'
		});	
		
		$('.footer').css({
			transition: 'all 0.2s',
			'-webkit-transform': 'translateY(30px)',
			'-moz-transform': 'translateY(30px)',
			transform: 'translateY(30px)'
		});
	});		
	$('#dimmer2').hide();
}

function showTopMenu(){
	$('#menu').css({
		transition: 'all 0.2s',
		'-webkit-transform': 'translateY(0px)',
		'-moz-transform': 'translateY(0px)',
		transform: 'translateY(0px)'
	});
	$('.footer').css({
		transition: 'all 0.2s',
		'-webkit-transform': 'translateY(-200px)',
		'-moz-transform': 'translateY(-200px)',
		transform: 'translateY(-200px)'
	});
	$('#dimmer2').show();
}

function toggleOverviewMode(){
	
	if($('.footer').css(trans_key) != 'matrix(1, 0, 0, 1, 0, 30)'){
		$('.footer').css({
			transition: 'all 0.2s',
			'-webkit-transform': 'translateY(30px)',
			'-moz-transform': 'translateY(30px)',
			transform: 'translateY(30px)'
		});	
	}
	else{
		$('.footer').css({
			transition: 'all 0.2s',
			'-webkit-transform': 'translateY(-320px)',
'-moz-transform': 'translateY(-320px)',
transform: 'translateY(-320px)'
		});	
	}
}



function closeOverviewMode(){
	$('.footer').css({
		transition: 'all 0.2s',
		'-webkit-transform': 'translateY(0px)',
		'-moz-transform': 'translateY(0px)',
		transform: 'translateY(0px)'
	});	
}

function closeAllLayers(){
	hideInfoWindow();
	closeOverviewMode()
	$('.overlay').hide();	
	closeLeftNav()	
	$('#dimmmer').hide();
}

///////////////////// function for initializing ftscroller with custom overscroll->swipe behaviour /////////////////////////		
function initFTscroller(){
	
	$('.ftScrollerVertical:visible').not('.FTinit').each(function(idx){
		id = $(this).attr('id');
		// init ftscroller
		
		scrollerV = new FTScroller(document.getElementById(id), {
			scrollingX: false,
			scrollingY: true,
			updateOnWindowResize: true,
			alwaysScroll: false,
			scrollResponseBoundry: 1,
			scrollBoundary: 1
		});
		
		$(this).addClass('FTinit');
		$(this)
		.on('touchstart',function(e){
			var t = e.originalEvent.touches[0];
			touchx = t.clientX;
			touchy = t.clientY;
		})
		.on('touchmove',function(e){		
			var t = e.originalEvent.touches[0],
			deltaX = touchx - t.clientX,
			deltaY = touchy - t.clientY,
			absX = Math.abs(deltaX),                            
			absY = Math.abs(deltaY);                           
			if(absY > absX) {   
				e.stopPropagation();		
			}
		})
		
	})
	
	$('.ftScrollerlHorizontal:visible').not('.FTinit').each(function(idx){
		id = $(this).attr('id');
		// init ftscroller
		
		scrollerH = new FTScroller(document.getElementById(id), {
			scrollingX: true,
			scrollingY: false,
			updateOnWindowResize: true,
			alwaysScroll: false,
			scrollbars: true,
			scrollResponseBoundry: 15,
			scrollBoundary: 5
		});
		$(this).addClass('FTinit');
		$(this)
		.on('touchstart',function(e){
			var t = e.originalEvent.touches[0];
			touchx = t.clientX;
			touchy = t.clientY;
		})
		.on('touchmove',function(e){		
			var t = e.originalEvent.touches[0],
			deltaX = touchx - t.clientX,
			deltaY = touchy - t.clientY,
			absX = Math.abs(deltaX),                            
			absY = Math.abs(deltaY);                           
			if(absX > absY) {   
				
				e.stopPropagation();		
			}
		})
	})
}

// init key-events
function keyevents(){
	/*$(window).keyup(function(e) {
		e.preventDefault()
		if (e.keyCode == 80) {
			slidey.prev()
		} 
		else  if (e.keyCode == 32) {
			slidey.next()
		}
		else  if (e.keyCode == 68) {
			_toggleDebugMode()
		}
		else  if (e.keyCode == 40) {
			slidey.down()
		}
		else  if (e.keyCode == 38) {
			slidey.up()
		}
		else  if (e.keyCode == 39) {
			slidey.right()
		}
		else  if (e.keyCode == 37) {
			slidey.left()
		}
	});	*/
}

$(document).ready(function(){
	slidey = $('#wrapper').fsSlider({
		debugMode: false,
		dirIndicator: false,
		minSwipeDistance: 120,
		animationDelay: 300
	});	
	// attach optional custom events returned by the plugin 
	slidey.obj.on("slidechanged", function() {	
		
		initFTscroller()
		initAnimations()
		initLightbox()
		$('.center').center({
			against: 'parent'	 
		});
		
		//$('audio')[0].play();
		//$('audio').animate({volume: 0}, 1000);
		//$('#overlay-top-2 > iframe').attr('src','/admin/index.cfm?editMagazinSlide='+$('.activeSlide').data('id'))
		
		keyevents()
	
	});
	
	$('#closeOverlay2').on('click',function(){
		showOverlay(2)
	})
	$('#closeOverlay3').on('click',function(){
		showOverlay(3)
	})
	$('#closeOverlay4').on('click',function(){
		showOverlay(4)
	})
	
	
	initFTscroller()
	initAnimations()
	initLightbox()
	
	
	$('#lightbox>div').on('touchmove',function(e){
		e.stopPropagation();	
	})
	
	
  	$('#dimmer2').on('click touchmove',function(){
		closeTopMenu()
	})
  
   	$('.center').center({
		against: 'parent'	 
	});
	
	 $('.valign').vAlign();
	
	setTimeout(function(){
		$('.image>img').addClass('zoom')	
	},500)
	

	slidey.obj.on("sliding", function() {
		//$('#slidedin').stop().css({opacity:0})
		//$('#moving').css({opacity:1})
	});
	slidey.obj.on("outofbounds", function() {
		//$('#outofbounds').animate({opacity:1}).delay(750).animate({opacity:0})	
	});
	slidey.obj.on("slidingaborted slidingend", function() {
		//$('#moving').css({opacity:0})
	});
	
	$('#rotate div').vAlign();
	
	// init menu
	$('#menuhandle').on('click',function(){
		toggleTopMenu()
	})

	
	
	
	$(window).on('resize',function(){
		$('.center').center({
			against: 'parent'	 
		});	
	})
})
		