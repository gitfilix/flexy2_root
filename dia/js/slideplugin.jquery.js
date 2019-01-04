

(function ( $ ) {
	$.fn.fsSlider = function( options ) {
		// options
		var settings = $.extend({
			// set defaults
			debugMode: false,
			animationDelay: 300,
			dirIndicator: true,
			minSwipeDistance: 80
		}, options );	
		
		// check for css vendor-prefix
		if (Modernizr.csstransforms3d) {
			var trans_key = Modernizr.prefixed('transform').replace(/([A-Z])/g, function(str,m1){ return '-' + m1.toLowerCase(); }).replace(/^ms-/,'-ms-');
		
		} else if (Modernizr.csstransforms) {
			var trans_key = Modernizr.prefixed('transform').replace(/([A-Z])/g, function(str,m1){ return '-' + m1.toLowerCase(); }).replace(/^ms-/,'-ms-');
		}
	
		var debug = settings.debugMode
		var dirIndicator = settings.dirIndicator
		var $wrapper = $(this)
		var $wrapperOrigWidth = $wrapper.width()
		var $wrapperOrigHeight = $wrapper.height()
		var $innerwrapper = $('ul',$wrapper).first()
		var animationDelay = settings.animationDelay
		var minSwipeDistance = settings.minSwipeDistance
		
		$('#debugToggler').on('click',function(){
			_toggleDebugMode()
		})
		
		$('#darrow').on('click',function(){ down() })
		$('#uarrow').on('click',function(){ up() })
		$('#rarrow').on('click',function(){ right() })
		$('#larrow').on('click',function(){ left() })
		
		if(!dirIndicator) $('#dirIndicator').hide();
		
		_loadChapterWithSlide = function(chapter,slide){
			// determine actual chapter
			
			// check if jumpTo chapter is before or after (determines direction left/right)
			dir = 'right'
			// load chapter before or afer
			$.get('inc/matrix.cfm',{slideID: slide},function(data){
				$innerwrapper.replaceWith(data)
				//moveSlideUp(10);
				
				reInitCanvas()
				_initTouchEvents()
			});	
			// translate to new position
			//moveToSlide(dir,slide)	
		}
		
		_initJumpTo = function(){
			
			$wrapper.find('.jumpTo').each(function(idx,item){
				$(this).off();
				$(this).on('click',function(e){
					$('#loading').show()
					setTimeout(function(){
						_loadChapterWithSlide($(item).data('chapterid'),$(item).data('slideid'))							
					},300)
					
				})	
			})
		}
		
		_initJumpTo()
		
		_toggleDebugMode = function(){
			if($('#debugWrapper').length > 0){
				_closeDebugMode();
				$('#debugToggler').css({
					top:10
				})
			}
			else{
				_initDebugMode();	
				$('#debugToggler').css({
					top:(-$(window).height()/3)+10 	
				})
			}		
		}
		
		_initDebugMode = function(){
			//$wrapper = $('body')	
			$wrapper.css({
				width: $(window).width() / 3,
				height: $(window).height() / 3,
				marginLeft: $(window).width() / 3,
				marginTop: $(window).height() / 3,
				position: 'relative',
				overflow: 'visible'
			})
			
			$('ul,li',$wrapper).first().css({
				border: '1px solid silver',
				height: $(window).height() / 3,
				overflow: 'hidden'
			})
			
			$debug_innerWidth = $('<div />',{id:'debug_innerWidth'}).html('innerWidth: <span></span>')
			$debug_innerHeight = $('<div />',{id:'debug_innerHeight'}).html('innerHeight: <span></span>')
			$debug_actSlideID = $('<div />',{id:'debug_actSlideID'}).html('actSlideID: <span></span>')
			$debug_leftSlide = $('<div />',{id:'debug_leftSlide'}).html('leftSlide: <span></span>')
			$debug_rightSlide = $('<div />',{id:'debug_rightSlide'}).html('rightSlide: <span></span>')
			$debug_topSlide = $('<div />',{id:'debug_topSlide'}).html('topSlide: <span></span>')
			$debug_bottomSlide = $('<div />',{id:'debug_bottomSlide'}).html('bottomSlide: <span></span>')
			$debug_hasLeftSlide = $('<div />',{id:'debug_hasLeftSlide'}).html('hasLeftSlide: <span></span>')
			$debug_hasRightSlide = $('<div />',{id:'debug_hasRightSlide'}).html('hasRightSlide: <span></span>')
			$debug_hasTopSlide = $('<div />',{id:'debug_hasTopSlide'}).html('hasTopSlide: <span></span>')
			$debug_hasBottomSlide = $('<div />',{id:'debug_hasBottomSlide'}).html('hasBottomSlide: <span></span>')
			$debug_rightChapter = $('<div />',{id:'debug_rightChapter'}).html('rightChapter: <span></span>')
			$debug_leftChapter = $('<div />',{id:'debug_leftChapter'}).html('leftChapter: <span></span>')
			
			$debugCover1 = $('<div />',{
				id: 'debugCover1'	
			}).css({
				width: ($wrapper.width()*3),
				height:($wrapper.height()),
				position: 'absolute',
				left:0,
				top:$wrapper.height(),
				backgroundColor: 'rgba(255,255,255,0.9)'	
			}).appendTo('body')
			
			$debugCover2 = $('<div />',{
				id: 'debugCover2'	
			}).css({
				width: ($wrapper.width()+5),
				height:($wrapper.height()),
				position: 'absolute',
				left:0,
				top:0,
				backgroundColor: 'rgba(255,255,255,0.9)'	
			}).appendTo('body')
			
			$debugCover3 = $('<div />',{
				id: 'debugCover3'	
			}).css({
				width: ($wrapper.width()*2)+5,
				height:($wrapper.height()*2)+5,
				position: 'absolute',
				left:0,
				top:-$wrapper.height()*2,
				backgroundColor: 'rgba(255,255,255,0.9)'	
			}).appendTo('body')
			
			
			$debugWrapper = $('<div />',{
				id: 'debugWrapper'	
			}).css({
				width: $wrapper.width()-40,
				height:($wrapper.height()*2)-40,
				position: 'absolute',
				right:0,
				padding:20,
				bottom:$wrapper.height()*2,
				backgroundColor: 'rgba(255,255,255,0.9)'	
			}).html('DEBUGGER<br/><br/>').appendTo('body')
			
			$debugWrapper.append($debug_innerWidth)
			$debugWrapper.append($debug_innerHeight)
			$debugWrapper.append($debug_actSlideID)
			$debugWrapper.append($debug_leftSlide)
			$debugWrapper.append($debug_rightSlide)
			$debugWrapper.append($debug_topSlide)
			$debugWrapper.append($debug_bottomSlide)
			$debugWrapper.append($debug_hasLeftSlide)
			$debugWrapper.append($debug_hasRightSlide)
			$debugWrapper.append($debug_leftSlide)
			$debugWrapper.append($debug_hasTopSlide)
			$debugWrapper.append($debug_hasBottomSlide)
			$debugWrapper.append($debug_rightChapter)
			$debugWrapper.append($debug_leftChapter)
			$debugWrapper.append('<br/>')
			$('#debugWrapper span').css('float','right')
			$('#debugWrapper > div').css('border-bottom','1px solid silver')
			
			$debugBTN_right = $('<button />',{id: 'right'}).html('right').appendTo('#debugWrapper').on('click',function(){right();})
			$debugBTN_left = $('<button />',{id: 'left'}).html('left').appendTo('#debugWrapper').on('click',function(){left();})
			$debugBTN_up = $('<button />',{id: 'up'}).html('up').appendTo('#debugWrapper').on('click',function(){up();})
			$debugBTN_up = $('<button />',{id: 'down'}).html('down').appendTo('#debugWrapper').on('click',function(){down();})
			$debugBTN_prev = $('<button />',{id: 'prev'}).html('prev').appendTo('#debugWrapper').on('click',function(){prev();})
			$debugBTN_next = $('<button />',{id: 'next'}).html('next').appendTo('#debugWrapper').on('click',function(){next();})	
			
			reInitCanvas()
			_setDebugOutput()
			
			$('#debugWrapper,#debugCover1,#debugCover2,#debugCover3').on('touchmove',function(e){
				e.preventDefault();	
			})	
		}
		
		_closeDebugMode = function(){
			$wrapper.css({
				width: $wrapperOrigWidth,
				height: $wrapperOrigHeight,
				marginLeft: 0,
				marginTop: 0,
				position: 'relative',
				overflow: 'hidden'
			})
			$('ul,li',$wrapper).first().css({
				border: '0px solid silver',
				height: $wrapperOrigHeight,
				overflow: 'hidden'		
			})
			$('#debugWrapper').remove();
			$('#debugCover1').remove();
			$('#debugCover2').remove();
			$('#debugCover3').remove();
			reInitCanvas()
		}

		_setDebugOutput = function(){	
			$('#debug_innerWidth span').html($innerWidth);
			$('#debug_innerHeight span').html($innerHeight);
			$('#debug_actSlideID span').html($actSlideID);
			$('#debug_leftSlide span').html($leftSlide);
			$('#debug_rightSlide span').html($rightSlide);
			$('#debug_topSlide span').html($topSlide);
			$('#debug_bottomSlide span').html($bottomSlide);
			$('#debug_hasLeftSlide span').html(hasLeftSlide);
			$('#debug_hasRightSlide span').html(hasRightSlide);
			$('#debug_hasTopSlide span').html(hasTopSlide);
			$('#debug_hasBottomSlide span').html(hasBottomSlide);
			$('#debug_rightChapter span').html(rightChapter);
			$('#debug_leftChapter span').html(leftChapter);
		}
		
		if(debug){
			_initDebugMode()
			$('#debugToggler').show()
		}
		
		$innerwrapper.width($wrapper.width() * 3)
		$innerwrapper.height($wrapper.height() * 3)
		$('.mainslide').width($wrapper.width())
		$('.mainslide').height($wrapper.height())
		$('.subslides li').height($wrapper.height())
		
		
		
		var $viewportWidth = $wrapper.width();
		var $viewportHeight = $wrapper.height();
		
		$innerwrapper.css({
			'-webkit-transform': 'translate3d(-'+$viewportWidth+'px,-'+$viewportHeight+'px,0)',
			'-moz-transform': 'translate(-'+$viewportWidth+'px,-'+$viewportHeight+'px)',
			transform: 'translate(-'+$viewportWidth+'px,-'+$viewportHeight+'px)'	
		})
		
		var $viewportCenterX = parseInt($innerwrapper.css(trans_key).split(',')[4]);
		var $viewportCenterY = parseInt($innerwrapper.css(trans_key).split(',')[5]);
		
		var $innerWidth = $innerwrapper.width();
		var $innerHeight = $innerwrapper.height();
		var $actSlideObj = $('.activeSlide');
		var $actSlideID = $('.activeSlide').data('id');
		var $leftSlide = ($('.mainslide').first().find('ul>li:nth-child(2)').data('id') > 0) ? $('.mainslide').first().find('ul>li:nth-child(2)').data('id') : 0;
		var $rightSlide = ($('.mainslide').last().find('ul>li:nth-child(2)').data('id') > 0) ? $('.mainslide').last().find('ul>li:nth-child(2)').data('id') : 0;
		/*if($rightSlide == 0){
			$rightSlide = ($('.mainslide').last().find('ul>li:nth-child(2)').data('id') > 0) ? $('.mainslide').last().find('ul>li:nth-child(2)').data('id') : 0 ;
		}
		else{
			moveSlideDown($rightSlide);
		}
		if($leftSlide == 0){
			$leftSlide = ($('.mainslide').first().find('ul>li:nth-child(2)').data('id') > 0) ? $('.mainslide').first().find('ul>li:nth-child(2)').data('id') : 0 ;
		}
		else{
			moveSlideDown($leftSlide);
		}*/
		
		
		
		var $topSlide = ($actSlideObj.prev().data('id') > 0) ? $actSlideObj.prev().data('id') : 0;
		var $bottomSlide = ($actSlideObj.next().data('id') > 0) ? $actSlideObj.next().data('id') : 0;
		var hasLeftSlide = ($leftSlide > 0) ? true : false ;
		var hasRightSlide = ($rightSlide > 0) ? true : false ;
		var hasTopSlide = ($topSlide > 0) ? true : false ;
		var hasBottomSlide = ($bottomSlide > 0) ? true : false ;
		var rightChapter = $('#rightSlide').data('chapterid')
		var leftChapter = $('#leftSlide').data('chapterid')
		var dir = ''
		var touch
		var startPoint, startPointY, startTime, delta, endPoint, endPointY
		var dragging
		var offset = 22
		var delta = 0
		var deltaY = 0
		
		!hasLeftSlide ? $('#left').hide() : $('#left').show()
		!hasRightSlide ? $('#right').hide() : $('#right').show()
		!hasBottomSlide ? $('#down').hide() : $('#down').show()
		!hasTopSlide ? $('#up').hide() : $('#up').show()
		
		!hasRightSlide && !hasBottomSlide ? $('#next').hide() : $('#next').show()
		!hasLeftSlide && !hasTopSlide ? $('#prev').hide() : $('#prev').show()
		
		_updateDirections = function(){
			hasBottomSlide ? $('#darrow').css({color:'black'}) : $('#darrow').css({color:'white'})
			hasTopSlide ? $('#uarrow').css({color:'black'}) : $('#uarrow').css({color:'white'})
			hasLeftSlide ? $('#larrow').css({color:'black'}) : $('#larrow').css({color:'white'})
			hasRightSlide ? $('#rarrow').css({color:'black'}) : $('#rarrow').css({color:'white'})	
		}
		
		if(dirIndicator){
			_updateDirections()
		}
		
		_initTouchEvents = function(){
			
			$innerwrapper.on('touchstart ', function(e) {
				
				//e.preventDefault();
				dir = ''
				startTime = (new Date()).getTime()
				
				touch = e.originalEvent.touches[0] || e.originalEvent.changedTouches[0];
				startPoint =  touch.pageX   
				startPointY =  touch.pageY
				
				
				dragging = true 
					
				
				
			});
			$innerwrapper.on('touchmove ', function(e) {
				e.preventDefault();
				
				touch = e.originalEvent.touches[0] || e.originalEvent.changedTouches[0];
				endPoint =  touch.pageX 
				endPointY =  touch.pageY
				delta = startPoint-endPoint
				deltaY = startPointY-endPointY
				temp = 0

				if(deltaY>offset && hasBottomSlide && dragging && (dir == '' || dir == 'down')){
					dir = 'down'
					$('#centerSlide').css({
						'-webkit-transform': 'translate3d(0px,-'+(0 + deltaY) +'px,0)',
						'-moz-transform': 'translate(0px,-'+(0 + deltaY) +'px)',
						'transform': 'translate(0px,-'+(0 + deltaY) +'px)'
					})
				}
				else if (deltaY<-offset && hasTopSlide && dragging && (dir == '' || dir == 'up')){
					dir = 'up'
					$('#centerSlide').css({
						'-webkit-transform': 'translate3d(0px,'+(0 - deltaY) +'px,0px)',
						'-moz-transform': 'translate(0px,'+(0 +- deltaY) +'px)',
						'transform': 'translate(0px,'+(0 - deltaY) +'px)'
					})
				}
	
				//right
				else if(delta>offset && dir != 'down' && dir != 'up' && hasRightSlide && dragging && (dir == '' || dir == 'right')){
					dir = 'right'
					$('#mag-wrapper').css({
						'-webkit-transform': 'translate3d(-' + ($viewportWidth + delta) + 'px,-'+$viewportHeight+'px,0)',
						'-moz-transform': 'translate(-' + ($viewportWidth + delta) + 'px,-'+$viewportHeight+'px)',
						'transform': 'translate(-' + ($viewportWidth + delta) + 'px,-'+$viewportHeight+'px)',
					})
					
				}
				// left
				else if(delta<-offset && dir != 'down' && dir != 'up' && hasLeftSlide && dragging && (dir == '' || dir == 'left')){
					dir = 'left'
					$('#mag-wrapper').css({
						'-webkit-transform': 'translate3d(-' + ($viewportWidth  + delta)+ 'px,-'+$viewportHeight+'px,0)',
						'-moz-transform': 'translate(-' + ($viewportWidth  + delta)+ 'px,-'+$viewportHeight+'px)',
						'transform': 'translate(-' + ($viewportWidth  + delta)+ 'px,-'+$viewportHeight+'px)'
					})
					
				}
				else{
					//alert('else statement')
				}
				
				if(dir!='' && temp == 0){
					$wrapper.trigger("sliding");		
					temp = 1
				}
				
			});	
			$innerwrapper.on('touchend ', function(e) {
				if(dir != ''){
					if(dir=='right' || dir == 'left'){
						deltax = delta.toString().replace('-','')
					}
					else if(dir=='down' || dir == 'up'){
						deltax = deltaY.toString().replace('-','')
					}
					
					if(deltax < minSwipeDistance && dir != '' && dragging){
						$wrapper.trigger("slidingaborted");		
						// rubberband effect
						if(dir == 'up' || dir == 'down'){
							$('#centerSlide').css({
								'-webkit-transform': 'translate3d(0px,0px,0px)',
								'-moz-transform': 'translate(0px,0px)',
								transform: 'translateY(0px)',
								transition: 'all ' + (animationDelay/2) + 'ms ease-out'
							})	
						}
						else{
							$innerwrapper.css({
								'-webkit-transform': 'translate3d(-'+$viewportWidth+'px,-'+$viewportHeight+'px,0)',
								'-moz-transform': 'translate(-'+$viewportWidth+'px,-'+$viewportHeight+'px)',
								transform: 'translate(-'+$viewportWidth+'px,-'+$viewportHeight+'px)',
								transition: 'all ' + (animationDelay/2) + 'ms ease-out'
							})
						}
						dir = '';	
					}
					else{
						if(dir == 'right' && delta > offset)
							right()
						else if(dir == 'left' && delta<-offset)
							left()
						else if(dir == 'up')
							up()
						else if(dir == 'down')
							down()
						else
							alert('dieser alert sollte nicht erscheinen')
					}
					$wrapper.trigger("slidingend");		
				}	
				// out of bounds
				else{
					dir = '';	
					if((delta > offset || delta < -offset || deltaY > offset || deltaY < -offset) && dragging){
						$wrapper.trigger("outofbounds");		
						shake()	
					}	
				}
				delta = 0
				deltaY = 0
				dragging = false 
				$('#slidedin').stop().css({opacity:0})
				
				
			});
		}
		
		
		
		
		_initTouchEvents()
		
		
		function reInitCanvas(){
			
			$wrapper = $('#wrapper')
			$wrapperOrigWidth = $wrapper.width()
			$wrapperOrigHeight = $wrapper.height()
			$innerwrapper = $('ul',$wrapper).first()
			
			$innerwrapper.width($wrapper.width() * 3)
			$innerwrapper.height($wrapper.height() * 3)
			
			$innerwrapper.css({
				'-webkit-transform': 'translate3d(-'+$viewportWidth+'px,-'+$viewportHeight+'px,0)',
				'-moz-transform': 'translate(-'+$viewportWidth+'px,-'+$viewportHeight+'px)',
				transform: 'translate(-'+$viewportWidth+'px,-'+$viewportHeight+'px)'	
			})
			
			
			
			$('.mainslide').width($wrapper.width())
			$('.mainslide').height($wrapper.height())
			$('.subslides li').height($wrapper.height())
			
			$viewportCenterX = parseInt($innerwrapper.css(trans_key).split(',')[4]);
			$viewportCenterY = parseInt($innerwrapper.css(trans_key).split(',')[5]);
			$viewportWidth = $wrapper.width();
			$viewportHeight = $wrapper.height();
			$innerWidth = $innerwrapper.width();
			$innerHeight = $innerwrapper.height();
			
			$innerwrapper.css({
				'-webkit-transform': 'translate3d(-'+$viewportWidth+'px,-'+$viewportHeight+'px,0)',
				'-moz-transform': 'translate(-'+$viewportWidth+'px,-'+$viewportHeight+'px)',
				transform: 'translate(-'+$viewportWidth+'px,-'+$viewportHeight+'px)'	
			})
		
			$actSlideObj = $('.activeSlide');
			$actSlideID = $actSlideObj.data('id');
			
			$leftSlide = ($('.mainslide').first().find('ul>li:nth-child(2)').data('id') > 0) ? $('.mainslide').first().find('ul>li:nth-child(2)').data('id') : 0;
			$rightSlide = ($('.mainslide').last().find('ul>li:nth-child(2)').data('id') > 0) ? $('.mainslide').last().find('ul>li:nth-child(2)').data('id') : 0;
			
			
			
			
			/*if($rightSlide == 0){
				$rightSlide = ($('.mainslide').last().find('ul>li:nth-child(2)').data('id') > 0) ? $('.mainslide').last().find('ul>li:nth-child(2)').data('id') : 0 ;
			}
			else{
				moveSlideDown($rightSlide);
			}
			
			if($leftSlide == 0){
				$leftSlide = ($('.mainslide').first().find('ul>li:nth-child(2)').data('id') > 0) ? $('.mainslide').first().find('ul>li:nth-child(2)').data('id') : 0 ;
			}
			else{
				moveSlideDown($leftSlide);
			}*/
			
		
			
			$topSlide = ($actSlideObj.prev().data('id') > 0) ? $actSlideObj.prev().data('id') : 0;
			$bottomSlide = ($actSlideObj.next().data('id') > 0) ? $actSlideObj.next().data('id') : 0;
			hasLeftSlide = ($leftSlide > 0) ? true : false ;
			hasRightSlide = ($rightSlide > 0) ? true : false ;
			hasTopSlide = ($topSlide > 0) ? true : false ;
			hasBottomSlide = ($bottomSlide > 0) ? true : false ;
			rightChapter = $('#rightSlide').data('chapterid')
			leftChapter = $('#leftSlide').data('chapterid')
			dir = '';
			
			if(debug || $('#debugWrapper').length > 0){
				_setDebugOutput()
			}
			
			!hasLeftSlide ? $('#left').hide() : $('#left').show()
			!hasRightSlide ? $('#right').hide() : $('#right').show()
			!hasBottomSlide ? $('#down').hide() : $('#down').show()
			!hasTopSlide ? $('#up').hide() : $('#up').show()
			
			!hasRightSlide && !hasBottomSlide ? $('#next').hide() : $('#next').show()
			!hasLeftSlide && !hasTopSlide ? $('#prev').hide() : $('#prev').show()
			
			if(dirIndicator){
				_updateDirections()
			}
			
			_initJumpTo()
			$('#loading').hide()
			$wrapper.trigger("slidechanged");		
		}

		
		function next(){
			if(hasBottomSlide){
				moveToSlide('down',$bottomSlide)	
			}
			else if(hasRightSlide){
				moveToSlide('right',$rightSlide)	
			}
			else{
				shake()
			}
		}
		
		function prev(){
			if(hasTopSlide){
				moveToSlide('up',$topSlide)	
			}
			else if(hasLeftSlide){
				moveToSlide('left',$leftSlide)	
			}
			else{
				shake()
			}
		}
		
		function right(){
			
			if(hasRightSlide){
				moveToSlide('right',$rightSlide)	
			}
			else{
				shake()
			}
		}
		
		function left(){
			if(hasLeftSlide){
				moveToSlide('left',$leftSlide)	
				
			}
			else{
				shake()
			}
		}
		
		function up(){
			if(hasTopSlide){
				moveToSlide('up',$topSlide)	
			}
			else{
				shake()
			}
		}
		
		function down(){
			if(hasBottomSlide){
				moveToSlide('down',$bottomSlide)	
			}
			else{
				shake()
			}
		}
		
		function shake(){
			$wrapper.addClass('shake animated')
			setTimeout(function(){
				$wrapper.removeClass('shake animated')	
			},500)	
		}
		
		function moveToSlide(direction,slideID){
			if(direction=='down'){
				$('#centerSlide').css({
					'-webkit-transform': 'translate3d(0px,-'+parseInt($viewportHeight) + 'px,0px)',
					'-moz-transform': 'translate(0px,-'+parseInt($viewportHeight) + 'px)',
					transform: 'translate(0px,-'+parseInt($viewportHeight) + 'px)',
					transition: 'all '+animationDelay+'ms ease-out'	
				})
				dta = ''
				if($('li[data-id="'+slideID+'"]').attr('data-nextID') != '' && $('li[data-id="'+slideID+'"]').attr('data-nextID') != null){
					$.get('inc/slide.cfm',{slideID: $('li[data-id="'+slideID+'"]').attr('data-nextID')},function(data){
						
						//$('#centerSlide .subslides').append(data)	
						dta = data;
					});	
				}
				setTimeout(function(){
					
					if($('li[data-id="'+slideID+'"]').attr('data-nextID') == '' || $('li[data-id="'+slideID+'"]').attr('data-nextID') == null){
						newLI = $('<li>',{
							class: 'subslide',
							style: 'background:white;height:'+$viewportHeight+'px;'	
						}).html('')
						$('#centerSlide .subslides').append(newLI)
					}
					
					$('#centerSlide .subslides').append(dta)	
					
					$('.activeSlide').removeClass('activeSlide');
					$('#centerSlide li[data-id="'+slideID+'"]').addClass('activeSlide')
					// set new activeSlide class
					
					// remove top li of this chapter
					$('#centerSlide li').first().remove();
					// appen next li if there is one
					
					$('#centerSlide').css({
						'-webkit-transform': 'translate3d(0px,0px,0px)',
						'-moz-transform': 'translate(0px,0px)',
						transform: 'translateY(0px)',
						transition: 'none'	
					})	
					
					reInitCanvas();
				},animationDelay)
				
			}
			else if(direction=='up'){
				$('#centerSlide').css({
					'-webkit-transform': 'translate3d(0px,'+ parseInt($viewportHeight) + 'px,0px)',
					'-moz-transform': 'translate(0px,'+ parseInt($viewportHeight) + 'px)',
					transform: 'translate(0px,'+ parseInt($viewportHeight) + 'px)',
					transition: 'all '+animationDelay+'ms  ease-in'	
				})
				dta = ''
				if($('li[data-id="'+slideID+'"]').attr('data-prevID') != '' && $('li[data-id="'+slideID+'"]').attr('data-prevID') != null){
					$.get('inc/slide.cfm',{slideID: $('li[data-id="'+slideID+'"]').attr('data-prevID')},function(data){
						//$('#centerSlide .subslides').prepend(data)
						dta = data;
					});		
				}	
				setTimeout(function(){	
					// append empty div
					if($('li[data-id="'+slideID+'"]').attr('data-prevID') == '' || $('li[data-id="'+slideID+'"]').attr('data-prevID') == null){
						newLI = $('<li>',{
							class: 'subslide',
							style: 'background:white;height:'+$viewportHeight+'px;'	
						}).html('')
						$('#centerSlide .subslides').prepend(newLI)
					}
					else if(dta != ''){
						$('#centerSlide .subslides').prepend(dta)
					}
					
					$('.activeSlide').removeClass('activeSlide');
					$('#centerSlide li[data-id="'+slideID+'"]').addClass('activeSlide')
					// set new activeSlide class
					// remove bottom li of this chapter
					$('#centerSlide li').last().remove();
					// appen next li if there is one
					
					$('#centerSlide').css({
						'-webkit-transform': 'translate3d(0px,0px,0px)',
						'-moz-transform': 'translate(0px,0px)',
						transform: 'translateY(0px)',
						transition: 'none'	
					})	
					
					reInitCanvas();
				},animationDelay)
				
			}
			else if(direction=='right'){
				
				if($('li[data-chapterid="'+rightChapter+'"]').attr('data-nextchapterid') != '' && $('li[data-chapterid="'+rightChapter+'"]').attr('data-nextchapterid') != null){
					$.get('inc/chapter.cfm',{chapterid: $('li[data-chapterid="'+rightChapter+'"]').attr('data-nextchapterid')},function(data){
						$innerwrapper.append(data)
					});		
					
				}
				x = 2 * $viewportWidth
				$innerwrapper.css({
					'-webkit-transform': 'translate3d(-'+ x + 'px,-'+parseInt($viewportHeight)+'px,0)',
					'-moz-transform': 'translate(-'+ x + 'px,-'+parseInt($viewportHeight)+'px)',
					transform: 'translate(-'+ x + 'px,-'+parseInt($viewportHeight)+'px)',
					'-webkit-transition': 'all '+animationDelay+'ms linear',
					'-moz-transition': 'all '+animationDelay+'ms linear',
					transition: 'all '+animationDelay+'ms  ease-in'	
				})
				setTimeout(function(){
					$innerwrapper.css({
						'-webkit-transition': 'none',
						'-moz-transition': 'none',
						transition: 'none'	
					})
					// set new activeSlide class
					// remove top li of this chapter
					if($('li[data-chapterid="'+rightChapter+'"]').attr('data-nextchapterid') == '' || $('li[data-chapterid="'+rightChapter+'"]').attr('data-nextchapterid') == null){
						newUL = '<li class="mainslide" data-chapterID="0" data-nextchapterid="0" data-prevchapterid="0"><ul class="subslides"><li style="background:white;height:'+$viewportHeight+'px;"></li><li style="background:white;height:'+$viewportHeight+'px;"></li><li style="background:white;height:'+$viewportHeight+'px;"></li></ul></li>'	
						$('#mag-wrapper').append(newUL)	
					}
	
					$('#leftSlide').remove();
					$('#centerSlide').attr('id','leftSlide')
					$('#leftSlide').css({
						'-webkit-transform': 'translate3d(0px,0px,0px)',
						'-moz-transform': 'translate(0px,0px)',
						'transform': 'translate(0px,0px)',
						'-webkit-transition': 'none',
						transition: 'none'	
					})
					
					$('#rightSlide').attr('id','centerSlide')
					$('#centerSlide').css({
						'-webkit-transform': 'translate3d(0px,0px,0px)',
						'-moz-transform': 'translate(0px,0px)',
						transform: 'translate(0px,0px)'	,
						'-webkit-transition': 'none',
						transition: 'none'
					})
					$('.mainslide').last().attr('id','rightSlide')
					
					$('.activeSlide').removeClass('activeSlide');
					
					$('li[data-id="'+slideID+'"]').addClass('activeSlide')
					
					//moveSlideDown($rightSlide);
					
					
					$innerwrapper.css({
						'-webkit-transform': 'translate3d(-'+ $viewportWidth + 'px,-'+parseInt($viewportHeight)+'px,0)',
						'-moz-transform': 'translate(-'+ $viewportWidth + 'px,-'+parseInt($viewportHeight)+'px)',
						transform: 'translate(-'+ $viewportWidth + 'px,-'+parseInt($viewportHeight)+'px)',
						transition: 'none'
					})
					
				
					
					reInitCanvas();
					
					
				},animationDelay)
			}
			else if(direction=='left'){
				
				x = 0 * $viewportWidth
				$innerwrapper.css({
					'-webkit-transform': 'translate3d('+ x + 'px,-'+parseInt($viewportHeight)+'px,0)',
					'-moz-transform': 'translate('+ x + 'px,-'+parseInt($viewportHeight)+'px)',
					transform: 'translate('+ x + 'px,-'+parseInt($viewportHeight)+'px)',
					transition: 'all '+animationDelay+'ms  ease-out'	
				})
				dta = ''
				if($('li[data-chapterid="'+leftChapter+'"]').attr('data-prevchapterid') != '' && $('li[data-chapterid="'+leftChapter+'"]').attr('data-prevchapterid') != null){
					$.get('inc/chapter.cfm',{chapterid: $('li[data-chapterid="'+leftChapter+'"]').attr('data-prevchapterid')},function(data){
						//$('#mag-wrapper').prepend(data)
						dta = data;
					});		
				}
				
				setTimeout(function(){
					$innerwrapper.css({
						'-webkit-transition': 'none',
						'-moz-transition': 'none',
						transition: 'none'	
					})
					
					
				
					// set new activeSlide class
					// remove top li of this chapter
					$('#rightSlide').remove();
					$('#centerSlide').attr('id','rightSlide')
					
					$('#leftSlide').attr('id','centerSlide')
					
					
					
					if($('li[data-chapterid="'+leftChapter+'"]').attr('data-prevchapterid') == '' || $('li[data-chapterid="'+leftChapter+'"]').attr('data-prevchapterid') == null){
						newUL = '<li class="mainslide" data-chapterID="0" data-nextchapterid="0" data-prevchapterid="0"><ul class="subslides"><li style="background:white;height:'+$viewportHeight+'px;"></li><li style="background:white;height:'+$viewportHeight+'px;"></li><li style="background:white;height:'+$viewportHeight+'px;"></li></ul></li>'
						newLI = $('<li>',{
							id: 'leftSlide',
							class: 'mainslide'
						}).html(newUL)
						$innerwrapper.prepend(newUL)	
					}	
					else if(dta != ''){
						$innerwrapper.prepend(dta)	
					}
					
					
					$('.mainslide').first().attr('id','leftSlide')
					
					$('#rightSlide').css({
						'-webkit-transform': 'translate3d(0px,0px,0px)',
						'-moz-transform': 'translate(0px,0px)',
						'transform': 'translate(0px,0px)',
						transition: 'none'	
					})
					
					$('#centerSlide').css({
						'-webkit-transform': 'translate3d(0px,0px,0px)',
						'-moz-transform': 'translate(0px,0px)',
						transform: 'translate(0px,0px)'	,
						transition: 'none'
					})
					
					
					$('.activeSlide').removeClass('activeSlide');
					$('li[data-id="'+slideID+'"]').addClass('activeSlide')
					
					//moveSlideDown($leftSlide);
					
					$innerwrapper.css({
						'-webkit-transform': 'translate3d(-'+ $viewportWidth + 'px,-'+parseInt($viewportHeight)+'px,0px)',
						'-moz-transform': 'translate(-'+ $viewportWidth + 'px,-'+parseInt($viewportHeight)+'px)',
						transform: 'translate(-'+ $viewportWidth + 'px,-'+parseInt($viewportHeight)+'px)',
						transition: 'none'
					})
					
					reInitCanvas();
					
				},animationDelay)
				
			}
		}
		
		function moveSlide(direction,slideID){
			if(direction=='down'){
				col = '#' + $('li[data-id="'+slideID+'"]').parent().parent().attr('id')
				$('li',col).last().remove();
				newLI = $('<li>',{
					class: 'subslide',
					style: 'background:white;height:'+$viewportHeight+'px;'	
				}).html('')
				$('.subslides',col).prepend(newLI)
				reInitCanvas();	
			}
			else if(direction=='up'){
				col = '#' + $('li[data-id="'+slideID+'"]').parent().parent().attr('id')
				$('li',col).first().remove();
				newLI = $('<li>',{
					class: 'subslide',
					style: 'background:white;height:'+$viewportHeight+'px;'	
				}).html('')
				$('.subslides',col).append(newLI)
				reInitCanvas();	
			}
		}
		
		function moveSlideUp(slideID){
			moveSlide('up',slideID)
		}
		
		function moveSlideDown(slideID){
			moveSlide('down',slideID)
		}

		$(window).keyup(function(e) {
			e.preventDefault()
		   if (e.keyCode == 80) {
			prev()
		  } 
		  
		   else  if (e.keyCode == 32) {
			next()
		  }
		  
		   else  if (e.keyCode == 68) {
			_toggleDebugMode()
		  }
		   else  if (e.keyCode == 40) {
			down()
		  }
			else  if (e.keyCode == 38) {
			up()
		  }
		   else  if (e.keyCode == 39) {
			right()
		  }
		  else  if (e.keyCode == 37) {
			left()
		  }
		});

		$(window).resize(function(){
			reInitCanvas();
		})
		
		return {
			actSlideID: $actSlideID,
			obj: $wrapper,
			next: function () { next() },
			prev: function () { prev() },
			left: function () { left() },
			right: function () { right() },
			up: function () { up() },
			down: function () { down() },
			reinit: function () { reInitCanvas() },
			jumpto: function (x,y) { _loadChapterWithSlide(x,y) },
			$this: this
		};
		
	}
	
	
	
}( jQuery ));