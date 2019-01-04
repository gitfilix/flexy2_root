// show splashscreen on initial load
$('#loadingSplashScreen').show();

// HTML5 video controls for lightbox overlay
function initVideoControls(divID){
	
	
		
	$(divID).each(function(){
		
		var player = $('#vidControlLightbox').parent()
		
	
		var getSetCurrentTime = createGetSetHandler(
			function() {
				$('input.time-slider', player).prop('value', $.prop(this, 'currentTime'));
			}, function() {
				try {
					$('video, audio', player).prop('currentTime', $.prop(this, 'value'));
				} catch (er) {}
			}
		);
		
		var getSetVolume = createGetSetHandler(
			function() {
				$('input.volume-slider', player).prop('value', $.prop(this, 'volume'));
	
			}, function() {
				$('video, audio', player).prop('volume', $.prop(this, 'value'));
			}
		);
		
		$('video, audio', this).bind('durationchange updateMediaState', function() {
			var duration = $.prop(this, 'duration');
			if (!duration) {
				return;
			}
			
			$('input.time-slider', player).prop({
				'max': duration,
				disabled: false
			});
			$('span.duration', player).text(formatSecondsAsTime(duration));
		}).bind('progress updateMediaState', function() {
			var buffered = $.prop(this, 'buffered');
			if (!buffered || !buffered.length) {
				return;
			}
			buffered = getActiveTimeRange(buffered, $.prop(this, 'currentTime'));
			$('span.progress', player).text(buffered[2]);
		}).bind('timeupdate', function() {
			f = $.prop(this, 'currentTime')
			
			$('span.current-time', player).text(formatSecondsAsTime(parseInt(f)));
			// adding progress to custom progressbar
			pro100 = $(divID).width();
			pro = (100 / pro100) * $.prop(this, 'currentTime') 
			proScreen = (pro100 / 100) * $.prop(this, 'currentTime')
			$('#vidProgressIndicator > div').css('width', proScreen + 'px')
		}).bind('timeupdate', getSetCurrentTime.get).bind('emptied', function() {
			$('input.time-slider', player).prop('disabled', true);
			$('span.duration', player).text('--');
			$('span.current-time', player).text(0);
			$('span.network-state', player).text(0);
			$('span.ready-state', player).text(0);
			$('span.paused-state', player).text($.prop(this, 'paused'));
			$('span.height-width', player).text('-/-');
			$('span.progress', player).text('0');
		}).bind('waiting playing loadedmetadata updateMediaState', function() {
			$('span.network-state', player).text($.prop(this, 'networkState'));
			$('span.ready-state', player).text($.prop(this, 'readyState'));
		}).bind('play pause', function() {
			$('span.paused-state', player).text($.prop(this, 'paused'));
		}).bind('volumechange', function() {
			var muted = $.prop(this, 'muted');
			$('span.muted-state', player).text(muted);
			$('input.muted', player).prop('checked', muted);
			$('span.volume', player).text($.prop(this, 'volume'));
		}).bind('volumechange', getSetVolume.get).bind('play pause', function() {
			$('span.paused-state', player).text($.prop(this, 'paused'));
		}).bind('loadedmetadata updateMediaState', function() {
			$('span.height-width', player).text($.prop(this, 'videoWidth') + '/' + $.prop(this, 'videoHeight'));
		}).each(function() {
			if ($.prop(this, 'readyState') > $.prop(this, 'HAVE_NOTHING')) {
				$(this).triggerHandler('updateMediaState');
			}
		});
	
		$('input.time-slider', player).bind('input', getSetCurrentTime.set).prop('value', 0);
		$('input.volume-slider', player).bind('input', getSetVolume.set);
		
		
	
		$('input.play', player).bind('click', function() {
			//alert($('span.paused-state').html());
			if($('span.paused-state').html()=='true'){
				$('video, audio', player)[0].play();	
				$('.play').val('Pause')
			}
			else{
				$('video, audio', player)[0].pause();
				$('.play').val('Play')
			}
			
		});
		$('input.pause', player).bind('click', function() {
			$('video, audio', player)[0].pause();
		});
		$('input.muted', player).bind('click updatemuted', function() {
			$('video, audio', player).prop('muted', $.prop(this, 'checked'));
		}).triggerHandler('updatemuted');
		$('input.controls', player).bind('click', function() {
			$('video, audio', player).prop('controls', $.prop(this, 'checked'));
		}).prop('checked', true);
	
	   /* $('select.load-media', player).bind('change', function() {
			var srces = $('option:selected', this).data('src');
			if (srces) {
				//the following code can be also replaced by the following line
				//$('video, audio', player).loadMediaSrc(srces).play();
				$('video, audio', player).removeAttr('src').find('source').remove().end().each(function() {
					var mediaElement = this;
					if (typeof srces == 'string') {
						srces = [srces];
					}
					$.each(srces, function(i, src) {
	
						if (typeof src == 'string') {
							src = {
								src: src
							};
						}
						$(document.createElement('source')).attr(src).appendTo(mediaElement);
					});
				})[0].load();
				$('video, audio', player)[0].play();
			}
		}).prop('selectedIndex', 0);*/
	})
}

function createGetSetHandler(get, set) {
    var throttleTimer;
    var blockedTimer;
    var blocked;
    return {
        get: function() {
            if (blocked) {
                return;
            }
            return get.apply(this, arguments);
        },
        set: function() {
            clearTimeout(throttleTimer);
            clearTimeout(blockedTimer);

            var that = this;
            var args = arguments;
            blocked = true;
            throttleTimer = setTimeout(function() {
                set.apply(that, args);
                blockedTimer = setTimeout(function() {
                    blocked = false;
                }, 30);
            }, 0);
        }
    };
};

function getActiveTimeRange(range, time) {
    var len = range.length;
    var index = -1;
    var start = 0;
    var end = 0;
    for (var i = 0; i < len; i++) {
        if (time >= (start = range.start(i)) && time <= (end = range.end(i))) {
            index = i;
            break;
        }
    }
    return [index, start, end];
};

///////////////////// function progress bar /////////////////////////
function progress(percent, $element) {
	var progressBarWidth = percent * $element.width() / 100;
	$element.find('div').animate({ width: progressBarWidth }, 100).html(percent + "%&nbsp;");
}

function showOverlay(x){
	$('.overlay').slideUp();
	if($('#'+x).css('display')=='block'){
		$('#'+x).slideUp();	
	}
	else{
		closeLeftNav()
		closeOverviewMode();
		$('#'+x).slideToggle();
			
	}
}

///////////////////// function to show info overlay /////////////////////////
function showInfoWindow(str){
	$('.infowindow').css({
		top: (($(window).height() / 2) - ($('.infowindow').height() / 2)),
		left: ($(window).width() / 2) - 160,
		width:280,
		color: 'white',
		fontSize: 24,
		padding: '20px',
		position: 'absolute',
		backgroundColor: 'red',
		zIndex:200
	}).html(str + '<div style="position:absolute;right:10px;top:10px;cursor:pointer;" onclick="hideInfoWindow();" style="cursor:pointer;">x</div>').fadeIn();
}

///////////////////// function to hide info overlay /////////////////////////
function hideInfoWindow(){
	$('.infowindow').fadeOut();
}

///////////////////// function for toggelöing left nav area (offcanvas) /////////////////////////
function toggleLeftNav(){
	hideInfoWindow()
	$('.overlay').hide();
	closeOverviewMode();
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

///////////////////// function for closing left nav area (offcanvas) /////////////////////////
function closeLeftNav(){
	$('#offcanvas').animate({
		left:-320
	},200);
}

///////////////////// function for toggeling top menu (offcanvas) /////////////////////////
function toggleTopMenu(){
	hideInfoWindow()
	if(parseInt($('#navigBar').css('transform').split(',')[5])=='-50'){
		$('#navigBar').css({
			transition: 'all 0.2s',
			transform: 'translateY(0)'
		});
		
		/*$('.footer').css({
			transition: 'all 0.2s',
			transform: 'translateY(0)'
		});*/
		/*$('.reveal').css({
			opacity: 0
		})
		$('body').css({
			background: '#fff'
		})*/
	}
	else{
		closeLeftNav();
		closeTopMenu();		
	}
}

///////////////////// function for hiding top menu (offcanvas) /////////////////////////
function closeTopMenu(){
	$('.overlay').fadeOut(500,function(){
		$('#navigBar').css({
			transition: 'all 0.2s',
			transform: 'translateY(-50px)'
		});	
		/*$('.footer').css({
			transition: 'all 0.2s',
			transform: 'translateY(280px)'
		});
		$('.reveal').css({
			opacity: 1
		})*/
	});		
}

///////////////////// function for showing top menu (offcanvas) /////////////////////////
function showTopMenu(){
	$('#navigBar').css({
		transition: 'all 0.5s',
		transform: 'translateY(0px)'
	});
}

function toggleOverviewMode(){
	if($('.footer').css('transform') != 'matrix(1, 0, 0, 1, 0, 0)'){
		$('.footer').css({
			transition: 'all 0.2s',
			transform: 'translateY(0)'
		});	
	}
	else{
		$('.footer').css({
			transition: 'all 0.2s',
			transform: 'translateY(280px)'
		});	
	}
}

function closeOverviewMode(){
	$('.footer').css({
		transition: 'all 0.2s',
		transform: 'translateY(280px)'
	});	
}

function closeAllLayers(){
	hideInfoWindow();
	closeOverviewMode()
	$('.overlay').hide();	
	closeLeftNav()	
	
}

function navigateTo(x){
	Reveal.slideTo(0,0,0)
	closeAllLayers()
}

 ///////////////////// function to initialize fittext /////////////////////////
function initFitText(){
	
}

///////////////////// function for initializing ftscroller with custom overscroll->swipe behaviour /////////////////////////
function initFTscroller(){
	$('.ftScrollerlVerticalWithSwipe:visible').not('.FTinit').each(function(){
		// init vars 
		var c = 0
		var d = 1
		var startPos = 0
		var endPos
		var endPosHeight
		// set id of current scroller
		id = $(this).attr('id');
		// init ftscroller
		var scroller1 = new FTScroller(document.getElementById(id), {
			scrollingX: false,
			scrollingY: true,
			updateOnWindowResize: true,
			alwaysScroll: true
		});
		// set vars based on ftscroller-events
		scroller1.addEventListener('scrollend', function (response) {
			// store scroll position
			endPos = response.scrollTop	
			// if has reached bottom set scroller-offset at bottom
			if(c == 2){
				endPosHeight = endPos
			}
			// if has reached top, reset temp vars
			if(endPos != 0 && endPos != endPosHeight){
				c = 0
				d = 0 	
			}	
			// activate swipe bottom flag for next scroll-event
			if(c == 2){	
				c = 1;
				d = 0;	
			}
			// activate swipe bottom flag for next scroll-event
			if(d == 2){
				d = 1;
				c = 0;	
			}			
		});
		scroller1.addEventListener('scrollstart', function (response) {	
			// store scroll position
			startPos = response.scrollTop
			// if the scroller is on top
			if(startPos == 0){
				d = 1 	
			}
			// if the scroller is at bottom	
			if(startPos == endPosHeight){
				c = 1 	
			}	
		});	
		scroller1.addEventListener('reachedend', function (responsex) {
			// set temp var
			c = 2;	
			// reset position var
			endPos = responsex.scrollTop
			
		});
		scroller1.addEventListener('reachedstart', function (responsex) {
			// set temp var
			d = 2;	
			// reset position var
			endPos = 0
		});
		// handle overscroll / swipe
		scroller1.addEventListener('scroll', function (response) {
			// store actual position
			actPos = response.scrollTop	
			// check for swipe flag
			if((c == 1 && actPos > startPos && (actPos-startPos>=50))){
				// swipe to next slide
				Reveal.next();
				// reset temp vars
				c = 0
				d = 0
				// block further execution of scroll event
				return
			}
			else if(d == 1 && actPos < startPos && (startPos-actPos>=60)){
				// swipe to previous slide
				Reveal.prev();
				// reset temp vars
				c = 0
				d = 0
				// block further execution of scroll event
				return
			}
		}); 	
		// add flag as class
		$(this).addClass('FTinit');
		// prevent eventbubbeling for vertical touchmove
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
	
	$('.ftScrollerlHorizontalWithSwipe:visible').not('.FTinit').each(function(){
		// init vars 
		var c = 0
		var d = 1
		var startPos = 0
		var endPos
		var endPosWidth
		// set id of current scroller
		id = $(this).attr('id');
		// init ftscroller
		var scroller2 = new FTScroller(document.getElementById(id), {
			scrollingX: true,
			scrollingY: false,
			updateOnWindowResize: true,
			alwaysScroll: true
		});
		// set vars based on ftscroller-events
		scroller2.addEventListener('scrollend', function (response) {
			// store scroll position
			endPos = response.scrollLeft
			// if has reached bottom set scroller-offset at bottom
			if(c == 2){
				endPosWidth = endPos
			}
			// if has reached top, reset temp vars
			if(endPos != 0 && endPos != endPosWidth){
				c = 0
				d = 0 	
			}	
			// activate swipe bottom flag for next scroll-event
			if(c == 2){	
				c = 1;
				d = 0;	
			}
			// activate swipe bottom flag for next scroll-event
			if(d == 2){
				d = 1;
				c = 0;	
			}			
		});
		scroller2.addEventListener('scrollstart', function (response) {	
			// store scroll position
			startPos = response.scrollLeft
			// if the scroller is on top
			if(startPos == 0){
				d = 1 	
			}
			// if the scroller is at bottom	
			if(startPos == endPosWidth){
				c = 1 	
			}	
		});	
		scroller2.addEventListener('reachedend', function (responsex) {
			// set temp var
			c = 2;	
			// reset position var
			endPos = responsex.scrollLeft
			
		});
		scroller2.addEventListener('reachedstart', function (responsex) {
			// set temp var
			d = 2;	
			// reset position var
			endPos = 0
		});
		// handle overscroll / swipe
		scroller2.addEventListener('scroll', function (response) {
			// store actual position
			actPos = response.scrollLeft	
			// check for swipe flag
			if((c == 1 && actPos > startPos && (actPos-startPos>=50))){
				// swipe to next slide
				Reveal.next();
				// reset temp vars
				c = 0
				d = 0
				// block further execution of scroll event
				return
			}
			else if(d == 1 && actPos < startPos && (startPos-actPos>=60)){
				// swipe to previous slide
				Reveal.prev();
				// reset temp vars
				c = 0
				d = 0
				// block further execution of scroll event
				return
			}
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
	
	$('.ftScrollerlVertical:visible').not('.FTinit').each(function(){
		id = $(this).attr('id');
		// init ftscroller
		var scrollerV = new FTScroller(document.getElementById(id), {
			scrollingX: false,
			scrollingY: true,
			updateOnWindowResize: true,
			alwaysScroll: true
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
	
	$('.ftScrollerlHorizontal:visible').not('.FTinit').each(function(){
		id = $(this).attr('id');
		// init ftscroller
		var scrollerH = new FTScroller(document.getElementById(id), {
			scrollingX: true,
			scrollingY: false,
			updateOnWindowResize: true,
			alwaysScroll: true,
			scrollbars: false
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

	/*$('.ftScrollerlHorizontalWithSwipe, .ftScrollerlVerticalWithSwipe, .ftScrollerlHorizontal, .ftScrollerlVertical').on('touchmove',function(e){
		e.stopPropagation()	
	});*/
	
	
	
}

///////////////////// function for drawing sitemap indicator /////////////////////////
function drawSitemap(){
	$('#pageMap').stop().hide()
	$('#pm').empty();
	$('#pm').html('<h1>Ihre Position</h1>');
	chaptersCount = $('.slides>section').length;
	chapterList = $('<ul>');
	
	$('.slides>section').each(function(){
		cls = "sitemap-chapter";
		slideid = $(this).attr('id')
		if(slideid=='undefined'){
			slideid = $('section',$(this).attr('id'))
		}
		if($(this).hasClass('present')){
			cls = "sitemap-chapter sitemap-chapter-act";	
		}
		chapter = $('<li/>')
		.addClass(cls)
		.appendTo(chapterList);
		a = $('<span/>').html('<a href="#/'+slideid+'" style="text-decoration:none;">&bull;</a>').appendTo(chapter)
		if($('section',$(this)).length > 0){
			subChapterList = $('<ul>');
			$('section',$(this)).each(function(idx){
				if(idx > 0){
					slideid2 = $(this).attr('id')
					cls2 = "sitemap-subchapter";
					if($(this).hasClass('present')){
						cls2 = "sitemap-subchapter sitemap-subchapter-act";	
					}
					subChapter = $('<li/>')
					.addClass(cls2)
					.appendTo(subChapterList);
					b = $('<span/>').html('<a href="#/'+slideid2+'" style="text-decoration:none;">&bull;</a>').appendTo(subChapter)
				}
			})	
			subChapterList.appendTo(chapter)
		}	
	})	
	$('#pm').append(chapterList); //;
	$('#pageMap').center().stop().hide().fadeIn().delay(1000).fadeOut();
}

///////////////////// function for initializing lightboxes per slide /////////////////////////
function initLightbox(){
	$('.lightbox').css('cursor','pointer').click(function(e){			
		e.preventDefault();
		cnt = $(this).data('lightboxdiv');
		type = $(this).data('lightboxtype');
		html = $('#'+cnt).html();
		$('#lightbox > div').html(html);
		$('#lightbox').attr('class','');
		$('#lightbox').data('lightboxtype',type);
		$('#lightbox').addClass(type);
		$('#lightbox').animate({
			top:0	
		},1,function(){
			$('#lightbox').css({transition: '1s all',MozTransform: 'translateY(0px)',WebkitTransform: 'translateY(0px)',transform: 'translateY(0px)'})	
		});
		
	});	
}


///////////////////// function for closing slidebased lightbox overlay /////////////////////////
function closeLightbox(){	
	
		/*$('#lightbox').slideToggle(500,function(){
			$('#lightbox>div').empty();		
		});*/
		$('#lightbox').css({
			transition: '0.7s all',
			MozTransform: 'translateY('+-$(window).height()+'px)',
			WebkitTransform: 'translateY('+-$(window).height()+'px)',
			transform: 'translateY('+-$(window).height()+'px)'
		})	
	
	// pause video
	if($('video','#lightbox').length > 0){
		$('#vidProgressIndicator','#lightbox').remove();
		$('#vidControlLightbox','#lightbox').remove();
		$('video','#lightbox').remove();
		$('.videoCloseButton','#lightbox').remove();
	}
	if($('iframe[src*="youtube.com/embed/"]','#lightbox').length>0){
		window.setTimeout('$("#lightbox>div").empty()',700);
	}
	$('#lightbox').removeAttr('class');
	$('.playbtn').fadeIn()
}

///////////////////// function for initializing flippable elements /////////////////////////
function initFlip(){
	$('.flip').click(function(){
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

///////////////////// function for initializing swiper plugin (menu scroller) /////////////////////////
/*function initSwiper(){
	$('.footer .swiper-container').swiper({
		mode:'horizontal',
		loop: true,
		slidesPerView: 3,
		useCSS3Transforms: true	,
		freeMode: true,
		freeModeFluid: true,
		grabCursor:true
	  });	 
}*/

///////////////////// function for initializing videos /////////////////////////
function initVideos(){
	$('.hasVideo').each(function(){
		// init vars
		videoType = $(this).data('videotype'); // youtube, html5
		youtubeCode = $(this).data('youtubecode');
		videoSrc = $(this).data('videosource');
		displayType = $(this).data('displaytype'); // withinContainer, FullScreenVideoOverlay
		posterImage = $(this).data('videoposter');
		lighboxType = $(this).data('lightboxtype');
		autoplay = $(this).data('videoautoplay');
		inAnimation = $(this).data('videoinanimation');
		videoClose = $(this).data('videoclose');
		divID = $(this).attr('id');
		// set poster-Image
		if(posterImage != ''){
			$(this).css('background','transparent url("'+posterImage+'") center center no-repeat')	
			$(this).css('background-size','cover')	
		}
		// set Placeholder 
		if($(this).css('background-image') == 'none'){
			$(this).css('background','transparent url("img/zplus-schraffur.jpg") center center no-repeat')	
			$(this).css('background-size','cover')	
			$(this).css('height','100%')	
			$(this).css('position','relative')	
		}		
		else{
			$(this).css('height','100%')	
			$(this).css('position','relative')		
		}
		
		if(navigator.onLine){
			// YOUTUBE initialization
			if(videoType == 'youtube'){
				// set launcher-button
				$buttonDiv = $('<div></div>')
				.hide()
				.addClass('centered playbtn')
				.css({
					width: 100,
					textAlign: 'center',
					borderRadius: 7,
					background: 'red',
					color: 'white',
					padding:'1em',
					cursor: 'pointer'
					})
				.html('PLAY')
				.appendTo($(this))
				.center2()
				.show()
				.on('click',function(){
					// fade out PLAY button
					$(this).fadeOut(300);
					// construct the iframe tag
					$iFrameTag = $('<iframe src="http://www.youtube.com/embed/'+youtubeCode+'?controls=0&amp;showinfo=0&amp;modestbranding=1&amp;autoplay=1&amp;wmode=transparent&amp;enablejsapi=1&html5=1" width="100%" height="100%" frameborder="0" style="margin:0;padding:0;width: 100%; height: 100%;" allowfullscreen="1" title="YouTube video player"></iframe>');
					// in container view
					if(displayType == 'withinContainer'){
						// set the video tag to div-width offset
						if(inAnimation == 'slideInLeft'){
							$iFrameTag.css({
								WebKitTransform: 'translateX(-' + $('#'+divID).width() + 'px)',
								MozTransform: 'translateX(-' + $('#'+divID).width() + 'px)',
								transform: 'translateX(-' + $('#'+divID).width() + 'px)',
								transition: 'all 1000ms'
							})
						}
						else if(inAnimation == 'slideInRight'){
							$iFrameTag.css({
								WebKitTransform: 'translateX(' + $('#'+divID).width() + 'px)',
								MozTransform: 'translateX(' + $('#'+divID).width() + 'px)',
								transform: 'translateX(' + $('#'+divID).width() + 'px)',
								transition: 'all 1000ms'
							})
						}
						else if(inAnimation == 'slideInTop'){
							$iFrameTag.css({
								WebKitTransform: 'translateY(-' + $('#'+divID).height() + 'px)',
								MozTransform: 'translateY(-' + $('#'+divID).height() + 'px)',
								transform: 'translateY(-' + $('#'+divID).height() + 'px)',
								transition: 'all 1000ms'
							})
						}
						else if(inAnimation == 'slideInBottom'){
							$iFrameTag.css({
								WebKitTransform: 'translateY(' + $('#'+divID).height() + 'px)',
								MozTransform: 'translateY(' + $('#'+divID).height() + 'px)',
								transform: 'translateY(' + $('#'+divID).height() + 'px)',
								transition: 'all 1000ms'
							})
						}
						else if(inAnimation == 'fadeIn'){
							$iFrameTag.css({
								opacity:0,
								transition: 'all 1000ms'
							})
						}
						// create close button
						$closeButtonDiv = $('<div></div>')
						.addClass('videoCloseButton')
						.on('click',function(){
							// animate video to offet div-width
							$iFrameTag.css({
								WebKitTransform: 'translateX(-' + $('#'+divID).width() + 'px)',
								MozTransform: 'translateX(-' + $('#'+divID).width() + 'px)',
								transform: 'translateX(-' + $('#'+divID).width() + 'px)',
								transition: 'all 1000ms'
							})
							// remove close-button from DOM
							$('.videoCloseButton','#'+divID).remove();
							// after animation-end, remove from DOM
							window.setTimeout("$('iframe','#'+divID).remove();",1000)
							// show PLAY button again
							$buttonDiv.fadeIn();
						})
						.css({
							position: 'absolute',
							top: '0.5em',
							right: '0.5em',
							cursor: 'pointer',
							width: 30,
							height: 30,
							backgroundColor: 'red',
							borderRadius: '1em',
							textAlign: 'center',
							zIndex: 1002,
							color: 'white',
							display: 'none'
						})
						.html('x')
						// append created elems to the DOM
						$('#'+divID).append($iFrameTag)
						// only show closebutton if videoClose is true
						if(videoClose == true){
							$('#'+divID).append($closeButtonDiv)
						}
						$('#'+divID).append($buttonDiv)
						// set appearance depending on effect
						if(inAnimation != 'fadeIn'){
							window.setTimeout("$('iframe','#'+divID).css({WebKitTransform: 'translateX(0px)',MozTransform: 'translateX(0px)',transform: 'translateX(0px)',transition: 'all 500ms'})",500)
						}
						else if(inAnimation == 'fadeIn'){
							window.setTimeout("$('iframe','#'+divID).css({opacity:1,transition: 'all 500ms'})",500)
						}
						window.setTimeout("$('.videoCloseButton').fadeIn();",1000)
					}
					// full screen lightbox
					else if(displayType == 'FullScreenVideoOverlay'){
						html = $iFrameTag;
						$('#lightbox > div').append(html);
						$('#'+divID).append($buttonDiv)
						$('#lightbox').attr('class','');
						$('#lightbox').addClass(lighboxType);
						$('#lightbox').data('lightboxtype',lighboxType);
						if(lighboxType.indexOf('centered80') > -1){
							$('#lightbox').center();
							$('#lightbox').css({
								transition: '1s all',
								MozTransform: 'translateY(0px)',
								WebkitTransform: 'translateY(0px)',
								transform: 'translateY(0px)',
								display:'block'
							})	
						}
						else{
							$('#lightbox').css({
								transition: '1s all',
								MozTransform: 'translateY(0px)',
								WebkitTransform: 'translateY(0px)',
								transform: 'translateY(0px)',
								display:'block'
							})	
						}
					}
				})
			}
			// HTML5 video
			else if(videoType == 'html5'){
				c = divID
				// create PLAY button
				var $buttonDiv = $('<div></div>')
				.hide()
				.addClass('videolightbox')
				.css({
					width: 100,
					textAlign: 'center',
					borderRadius: 7,
					background: 'red',
					color: 'white',
					padding:'1em',
					cursor: 'pointer'
					})
				.html('PLAY')
				.appendTo($(this))
				.center2()
				.show()
				.on('click',function(){
					// fade out PLAY button
					$(this).fadeOut(300);
					// construct the video tag
					var $videoTag = $('<video poster="'+posterImage+'" src="'+videoSrc+'" preload="none" />')
					.css({
						width:'100%',
						height:'100%',
						'-webkit-transform-style': 'preserve-3d',
						zIndex:1000,
						position: 'absolute',
						backgroundColor: 'white',
						cursor: 'pointer'
					})
					// custom controls (because of ipad z-index bug with html5 video)
					var $videoControls = $('#vidControl').clone();
					$($videoControls)
					.css({
						width:200,
						fontSize: 16,
						left: '20%',
						margin: '0 auto',
						backgroundColor: 'silver',
						zIndex: 1002,
						position: 'absolute',
						bottom: '2em',
						borderRadius: '1em',
						display: 'none'
					})
					.attr('id','vidControlLightbox')
					// construct custom progressbar
					var $videoProgressBar = $('#vidProgress').clone();
					$($videoProgressBar)
					.css({
						width:'100%',
						height:5,
						bottom:0,
						zIndex:1002,
						position: 'absolute',
						backgroundColor: 'rgba(0,0,0,0.3)'
					})	
					.attr('id','vidProgressIndicator')
					// in container view
					if(displayType == 'withinContainer'){
						
						// set the video tag to div-width offset
						if(inAnimation == 'slideInLeft'){
							$videoTag.css({
								WebKitTransform: 'translateX(-' + $('#'+c).width() + 'px)',
								MozTransform: 'translateX(-' + $('#'+c).width() + 'px)',
								transform: 'translateX(-' + $('#'+c).width() + 'px)',
								transition: 'all 1000ms'
							})
						}
						else if(inAnimation == 'slideInRight'){
							$videoTag.css({
								WebKitTransform: 'translateX(' + $('#'+c).width() + 'px)',
								MozTransform: 'translateX(' + $('#'+c).width() + 'px)',
								transform: 'translateX(' + $('#'+c).width() + 'px)',
								transition: 'all 1000ms'
							})
						}
						else if(inAnimation == 'slideInTop'){
							$videoTag.css({
								WebKitTransform: 'translateY(-' + $('#'+c).height() + 'px)',
								MozTransform: 'translateY(-' + $('#'+c).height() + 'px)',
								transform: 'translateY(-' + $('#'+c).height() + 'px)',
								transition: 'all 1000ms'
							})
						}
						else if(inAnimation == 'slideInBottom'){
							$videoTag.css({
								WebKitTransform: 'translateY(' + $('#'+c).height() + 'px)',
								MozTransform: 'translateY(' + $('#'+c).height() + 'px)',
								transform: 'translateY(' + $('#'+c).height() + 'px)',
								transition: 'all 1000ms'
							})
						}
						else if(inAnimation == 'fadeIn'){
							$videoTag.css({
								opacity:0,
								transition: 'all 1000ms'
							})
						}
						// create close button
						$closeButtonDiv = $('<div></div>')
						.addClass('videoCloseButton')
						.on('click',function(){
							// animate video to offet div-width
							$videoTag.css({
								WebKitTransform: 'translateX(-' + $('#'+c).width() + 'px)',
								MozTransform: 'translateX(-' + $('#'+c).width() + 'px)',
								transform: 'translateX(-' + $('#'+c).width() + 'px)',
								transition: 'all 1000ms'
							})
							// pause video
							$('video','#'+c)[0].pause()
							// remove progressbar, close-button and video controls from DOM
							$('#vidProgressIndicator','#'+c).remove();
							$('#vidControlLightbox','#'+c).remove();
							$('.videoCloseButton','#'+c).remove();
							// after animation-end, remove from DOM
							window.setTimeout("$('video','#'+c).remove();",1000)
							// show PLAY button again
							$buttonDiv.fadeIn();
						})
						.css({
							position: 'absolute',
							top: '0.5em',
							right: '0.5em',
							cursor: 'pointer',
							width: 30,
							height: 30,
							backgroundColor: 'red',
							borderRadius: '1em',
							textAlign: 'center',
							zIndex: 1002,
							color: 'white',
							display: 'none'
						})
						.html('x')
						// append created elems to the DOM
						
						$('#'+c).append($videoTag)
						$('#'+c).append($videoControls)
						$('#'+c).append($videoProgressBar)
						if(videoClose == true){
							$('#'+c).append($closeButtonDiv)
						}
						$('#'+c).append($buttonDiv)
						if(inAnimation != 'fadeIn'){
							window.setTimeout("$('video','#'+c).css({WebKitTransform: 'translateX(0)',MozTransform: 'translateX(0px)',transform: 'translateX(0px)',transition: 'all 500ms'})",100)
						}
						else if(inAnimation == 'fadeIn'){
							window.setTimeout("$('video','#'+c).css({opacity:1,transition: 'all 500ms'})",100)
						}
						window.setTimeout("$('.videoCloseButton').fadeIn();",700)
						// calc center for cusom controls
						breite = $videoControls.width();
						links = ($('#'+c).width() / 2) - (breite / 2);
						$videoControls.css('left',links)
						fadeInVideoControls();
						initVideoControls('#'+c)
					}
					// full screen lightbox
					else if(displayType == 'FullScreenVideoOverlay'){
						html = $videoTag;
						ctrls = $videoControls
						pbar = $videoProgressBar
						$('#lightbox > div').html(html);
						$('#lightbox > div').append(ctrls);
						$('#lightbox > div').append(pbar);
						$('#lightbox').attr('class','');
						$('#lightbox').addClass(lighboxType);
						$('#lightbox').data('lightboxtype',lighboxType);
						// if centered 80% lightbox
						if(lighboxType.indexOf('centered80') > -1){
							$('#lightbox').center();
							$('#lightbox').css({
								transition: '1s all',
								MozTransform: 'translateY(0px)',
								WebkitTransform: 'translateY(0px)',
								transform: 'translateY(0px)',
								display:'block'
							})	
						}
						else{
							$('#lightbox').css({
								transition: '1s all',
								MozTransform: 'translateY(0px)',
								WebkitTransform: 'translateY(0px)',
								transform: 'translateY(0px)',
								display:'block'
							})	
						}
						breite = $videoControls.width();
						links = ($(window).width() / 2) - (breite / 2);
						$videoControls.css('left',links)
						fadeInVideoControls();
						initVideoControls('#lightbox')
					}
					// init custom video controls
					
					// autoplay Video
					$videoTag[0].play()	
					// on click pause video and show controls
					$videoTag.on('click',function(){
						// if clicked in paused state
						if($('span.paused-state').html()=='true'){
							hideVideoControls();	
							$videoTag[0].play();	
							$('.play').val('Pause')
						}
						// if clicked in play state
						else{
							showVideoControls()
							$videoTag[0].pause();
							$('.play').val('Play')
						}
					})
				})
			}
			
			if(autoplay==true){
				$( $buttonDiv ).trigger( "click" );
			}
		}
		else{
			// offline
			buttonDiv = $('<div></div>')
			.hide()
			.addClass('centered')
			.css({
				width: 200,
				textAlign: 'center',
				borderRadius: 7,
				background: 'red',
				color: 'white',
				padding:'1em'
				})
			.html('Your are offline<br/>no Video')
			.appendTo($(this))
			.center2()
			.show()
		}
	});
}

function fadeInVideoControls(){
	$('#vidControlLightbox').fadeIn().delay(1500).fadeOut();
}

function showVideoControls(){
	$('#vidControlLightbox').fadeIn();
}

function hideVideoControls(){
	$('#vidControlLightbox').fadeOut();
}


///////////////////// function for starting Mag (slide-engine and all slidebased plugins) /////////////////////////
function startMag(){ 
	// INITIALIZE NAVIGATION-MATRIX
	Reveal.initialize({
		width: '100%',
		height: '100%',
		controls: false,
		progress: false,
		history: true,
		mouseWheel: false,
		center: false,
		loop: true,
		theme: Reveal.getQueryHash().theme,
		//transition: Reveal.getQueryHash().transition || 'fade', // default/cube/page/concave/zoom/linear/fade/none
		backgroundTransition: 'none',
		previewLinks: true,
		margin: 0,
		overview: true,
		autoSlide: 0,				
		autoSlideStoppable: true,
		slideNumber: false,
		//parallaxBackgroundImage: 'img/clouds.jpg',
		//parallaxBackgroundSize: "3000px " +$(window).height() +"px",
		dependencies: [
			{ src: 'js/reveal.js-master/lib/js/classList.js', condition: function() { return !document.body.classList; } },
			{ src: 'js/reveal.js-master/plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
			{ src: 'js/reveal.js-master/plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
			{ src: 'js/reveal.js-master/plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
			{ src: 'js/reveal.js-master/plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } }
		]
	});
	
	// WHEN NAVIGATION-MATRIX IS READY TO NAVIGATE
	Reveal.addEventListener( 'ready', function( event ) {
		// -------------------------- init components ------------------------	
		initLightbox();
		initFlip();
		//initSwiper();
		//dirIndicators();
		initFTscroller();
		initVideos();
		// -------------------------- END init components ------------------------	
		
		// -------------------------- prevent horizontal swipe on overflowed divs ------------------------	
		
		mies()
		window.setTimeout('tpl2();tpl6();tpl7();tpl8();',100);
		
		/*if(navigator.onLine){
			$('.ytvideo-iframe').each(function(){
				$(this).attr('src',$(this).data('src'));
			});
		}*/
	} );
	
	var rtime = new Date(1, 1, 2000, 12,00,00);
	var timeout = false;
	var delta = 200;
	
	function resizeend() {
		if (new Date() - rtime < delta) {
			setTimeout(resizeend, delta);
		} else {
			timeout = false;
			//$('.overflow').unbind();
			mies();
			$('.centered').each(function(){
				$(this).center2()	
			});
		}               
	}
	
	window.addEventListener( 'resize', function( event ) {
		rtime = new Date();
		if (timeout === false) {
			timeout = true;
			setTimeout(resizeend, delta);
		}	
	});
	
	Reveal.addEventListener( 'slidechanged', function( event ) {
		
		//closeLightbox()
		//dirIndicators();
		// show position within the matrix
		drawSitemap();
		// tpl7 specific function execution
		tpl7onSlide(event.currentSlide);	
		// hide potential loading wheel
		$('#loadingWheel').hide()
		// clear all active videos (will be re-inited on button click)
		$('hasVideo').empty();
		// prepeare animations
		$('.anim').css('opacity',0);
		// execute custom animation on particular slide
		
		$('.anim',$(event.currentSlide)).each(function(idx){
			
			delay = $(this).data('inanimation').split('-')[0];
			anim = $(this).data('inanimation').split('-')[1];
			zeit = $(this).data('inanimation').split('-')[2];
			zt = zeit * 1000;
			dl = delay * 1000;
			if(anim=='fadeIn'){							
				$(this).delay(dl).animate({
					opacity: 1	
				},zt)
			}
			else if(anim=="slideInRight"){
				$(this).css({
					position:'relative',
					right:-$(window).width(),
					opacity:1
				}).delay(dl).animate({
					right:0	
				},zt,'swing')
			}
			else if(anim=="slideInLeft"){
				$(this).css({
					position:'relative',
					left:-$(window).width(),
					opacity:1
				}).delay(dl).animate({
					left:0	
				},zt,'swing')
			}
			else if(anim=="slideInTop"){
				$(this).css({
					position:'relative',
					top:-$(window).height(),
					opacity:1
				}).delay(dl).animate({
					top:0	
				},zt,'swing')
			}
			else if(anim=="slideInBottom"){
				$(this).css({
					position:'relative',
					bottom:-$(window).height(),
					opacity:1
				}).delay(dl).animate({
					bottom:0	
				},zt,'swing')
			}
			else if(anim=="scaleTextUp"){
				$(this).css({
					'font-size':'0em',
					opacity:1
				}).delay(dl).animate({
					'font-size':'2em'
					
				},zt,'swing')
			}	
		});		
	});
}

function mies(){
	d = Reveal.getCurrentSlide();
	$('.anim').css('opacity',0);
	$('.anim',$(d)).each(function(idx){
		delay = $(this).data('inanimation').split('-')[0];
		anim = $(this).data('inanimation').split('-')[1];
		zeit = $(this).data('inanimation').split('-')[2];
		zt = zeit * 1000;
		dl = delay * 1000;
		
		if(anim=='fadeIn'){							
			$(this).delay(dl).animate({
				opacity: 1	
			},zt)
		}
		else if(anim=="slideInRight"){
			$(this).css({
				position:'relative',
				right:-$(window).width(),
				opacity:1
			}).delay(dl).animate({
				right:0	
			},zt,'swing')
		}
		else if(anim=="slideInLeft"){
			$(this).css({
				position:'relative',
				left:-$(window).width(),
				opacity:1
			}).delay(dl).animate({
				left:0	
			},zt,'swing')
		}
		else if(anim=="slideInTop"){
			$(this).css({
				position:'relative',
				top:-$(window).height(),
				opacity:1
			}).delay(dl).animate({
				top:0	
			},zt,'swing')
		}
		else if(anim=="slideInBottom"){
			$(this).css({
				position:'relative',
				bottom:-$(window).height(),
				opacity:1
			}).delay(dl).animate({
				bottom:0	
			},zt,'swing')
		}
		else if(anim=="scaleTextUp"){
			$(this).css({
				'font-size':'0em',
				opacity:1
			}).delay(dl).animate({
				'font-size':'2em'
				
			},zt,'swing')
		}
	});	
	$('#loadingSplashScreen').hide()	
	//showTopMenu()
	//$('section').css('padding-top',50)
}

$(document).ready(function(){
	//$('#rotate div').vAlign();
	/*$('.ft-page').each(function(){
		wdt = parseInt($(window).height() / 2)
		$('.ft-page').html('<div style="height:100%;text-align:center;background-color:#333;opacity:0.8;"><img src="img/popup_ajax_loader.gif" style="margin-top:' + wdt + 'px;" /></div>');
	});*/

	$('#menuhandle').click(function(e){
		toggleTopMenu();	
	});
});

///////////////////// function for toggelöing left nav area (offcanvas) /////////////////////////
$('.footer .swiper-container').on('touchstart touchmove mousedown',function(e){
	e.stopPropagation()
})

///////////////////// on touch close all possible menus/overlays und prevent event bubbling (prevent rubberband) /////////////////////////
$(document).on('touchmove',function(e){
	 closeAllLayers()
	 closeTopMenu()
	 e.preventDefault();
});


