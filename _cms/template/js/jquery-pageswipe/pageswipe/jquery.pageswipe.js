// jQuery pageSwipe - Page swiping plugin for jQuery
// Copyright (C) 2012  Michiel Sikkes <michiel@firmhouse.com>
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
// 
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.



(function( $ ) {
	
  $.fn.pageSwipe = function( options ) {

	 //Set the default values, use comma to separate the settings, example:
	var defaults = {
		vpWidth: 768, //not manadatory
		vpHeight: $(window).height(), //not manadatory
		//initAjaxFile: '', //path to initial-file of the mag, mandatory
		playAudioJingle: '', //path to mp3-file, not mandatory
		jumpTo: null,
		jumpToType: 'fade', // fade, slide, load
		initOri: 1,
		initDevice: 'ipad' 
	}
	
	var options =  $.extend(defaults, options);
	var o = options;
	
	viewportHeight = o.vpHeight;
	deviceWidth = o.vpWidth;
	deviceHeight = $(window).height();
	
	if(o.initDevice=='ipad'){
		if(o.initOri==1){
			deviceWidth	= 768
			deviceHeight = 1024
		}
		else{
			deviceWidth	= 1024
			deviceHeight = 768
		}
	}
	else if(o.initDevice=='galaxyTab'){
		if(o.initOri==1){
			deviceWidth	= 800
			deviceHeight = 1280
		}
		else{
			deviceWidth	= 1280
			deviceHeight = 800
		}
	}
	else if(o.initDevice=='surface'){
		if(o.initOri==1){
			deviceWidth	= 768
			deviceHeight = 1366
		}
		else{
			deviceWidth	= 1366
			deviceHeight = 768
		}
	}
	
	
	
	/*if(o.initAjaxFile == ''){
		$('body').html('');
		alert('no initial File provided! Please correct, otherwise the mag can\' be loaded');	
		return;
	}
	else{
		$.get(o.initAjaxFile,'',function(data){
			$(this).append(data);
		});	
	}*/
	
	
	
    if (viewportHeight > deviceHeight) {
      remaining = viewportHeight - deviceHeight
      remainingHeight = (remaining / 2) + 'px '
      viewportHeight = deviceHeight
    } else {
      remainingHeight = ''  
    }
    
    pageswipe_viewport = $('<div class="pageswipe-viewport viewport"></div>')
    pageswipe_viewport.css({height: viewportHeight -50 + 'px', width: deviceWidth + 'px', margin: remainingHeight + 'auto', overflow: "hidden", position: "relative"})
    this.wrap(pageswipe_viewport)

	var numberOfPages = this.children('.page').length
    
    this.css({width: (numberOfPages * deviceWidth) + "px", position: "absolute"})
    this.children('.page').css({width: deviceWidth + 'px', "float": "left", "overflow-y": "hidden", "position": "relative"}) //"-webkit-overflow-scrolling": "touch", 
    
	//mrz 17/05/2013
	this.find('.subpage').css({width: deviceWidth + 'px', height: deviceHeight + 'px', "overflow-y": "hidden", "-webkit-overflow-scrolling": "touch"});
	this.find('section').css({height: deviceHeight + 'px',width: deviceWidth + 'px',"overflow-y": "hidden",  "-webkit-overflow-scrolling": "touch"});
	
	var that = this
    var pagesStartPosition = 0
	var subPagesStartPosition = 0
    var horizontalTouchStart = null
    var verticalTouchStart = null
    var scrollDirection = null
    var currentPage = 1
	var currentSubPage = 0
    var touchDown = false
	
	var dirRight = 0
	var dirLeft = 0
	var dirUp = 0
	var dirDown = 0

	var numberOfSubPages = numberOfSubPages = $('.subpage',$('.page')[0]).length

	if(window.orientation == 90 || window.orientation == -90){
		var breite = screen.height
		var hoehe = screen.width
	}
	else{
		var breite = screen.width	
		var hoehe = screen.height
	}
	
	$('#debugPage').html(1); // + '/'+ numberOfPages + ' - Subpage: '+ currentSubPage + '/' + numberOfSubPages);
	$('#debugPages').html(numberOfPages);
	$('#debugSubPage').html(currentSubPage);
	$('#debugSubPages').html(numberOfSubPages);
	$('#debugChapter').html($('.page:eq(0)').attr('title'));
	$('#debugPageTitle').html($('section:eq(0)').attr('title'));
    
    $(this).bind('webkitTransitionEnd', function () {
      this.style.WebkitTransition = ''
    })
    
    $(this).bind('otransitionend', function () {
      this.style.OTransition = ''
    })
    
    $(this).bind('transitionend', function () {
      this.style.MozTransition = ''
    })
    
    $(this).bind('MSTransitionEnd', function() {
      this.style.MSTransition = ''
    })
	
	loadNextChapter = function(chapterNr){
		//remove previous pages from the dom
		if(chapterNr>3){
			$('.page-1').html('&nbsp;');
			$('.page-'+(parseInt(chapterNr)-3)).html('&nbsp;');
			
			if($('.page-'+(parseInt(chapterNr)+3)).length){
				$('.page-'+(parseInt(chapterNr)+3)).html('&nbsp;');
			}
		} 
		else if(chapterNr==3){	
			if($('.page-'+(parseInt(chapterNr)+3)).length){
				$('.page-'+(parseInt(chapterNr)+3)).html('&nbsp;');
			}
		}
		else if(chapterNr<3){
			if($('.page-'+(parseInt(chapterNr)+3)).length){
				$('.page-'+(parseInt(chapterNr)+3)).html('&nbsp;');
			}
		}
		$.get('/mirza-in-progress/ajax_magPage.cfm',{chapterNr:chapterNr,orientation:$('body').attr('class').split(' ')[1],device:$('body').attr('class').split(' ')[0]},function(returnData){
			$('.page-'+chapterNr).html(returnData);
			$('.layoutElem').each(function(){
				if($(this).hasOverflow()){
					$(this).addClass('overflowed');
					alert(1)
				}
			});
			$('.hover').unbind('click');
			$('.hover').click(function(){
				if($(this).hasClass('flip')){
					$(this).removeClass('flip');	
				}
				else{
					$(this).addClass('flip');
				}
			});
			$('.article').unbind('click');
			$('.article').click(function(){
				 $.fancybox({
					'centerOnScroll': true,
					'type':'ajax',
					'href':'/mirza-in-progress/ajax_article.cfm?flexyCmsArticleID=1&width=80%&height=80%'
				});
			});
			/*$('.overflowed').unbind('touchmove');
			$('.overflowed').bind('touchmove', function(e){
				e.stopImmediatePropagation()
			});*/
			that.find('.subpage').css({width: deviceWidth + 'px', height: deviceHeight + 'px', "overflow-y": "hidden"});//, "-webkit-overflow-scrolling": "touch"
			that.find('section').css({height: deviceHeight + 'px',width: deviceWidth + 'px',"overflow-y": "hidden"});//,  "-webkit-overflow-scrolling": "touch"
			//alert('next chapter no. '+chapterNr+' is loaded and appended to the DOM!')
			// count .page with section-tag. must always be 2 or 3!
			p = $('section','.page').length;
			$('#pageCountInDOM').html(p);
		
			$('.overflowed').unbind('touchmove');
			$('.overflowed').bind('touchmove', function(e){
				e.stopImmediatePropagation()
			});
			$('body').unbind('touchmove');
			$('body').on('touchmove',function(e){
				e.stopImmediatePropagation()
			});
		})
	}
	
	setBaloon = function(right,left,up,down){
		if(right==1){	
			$('#dirRight').css({
				top: (hoehe / 2) - ($('#dirRight').width()/2)+25,
				display: 'block'
			});
		}else{
			$('#dirRight').css('display','none');
		}
		if(left==1){
			$('#dirLeft').css({
				top: (hoehe / 2) - ($('#dirLeft').width()/2)+25,
				display: 'block'
			});
		}else{
			$('#dirLeft').css('display','none');
		}
		if(up==1){
			$('#dirUp').css({
				left: (breite / 2) - ($('#dirUp').width()/2),
				display: 'block'
			});
		}else{
			$('#dirUp').css('display','none');
		}
		if(down==1){
			$('#dirDown').css({
				left: (breite / 2) - ($('#dirDown').width()/2),
				display: 'block'
			});
		}else{
			$('#dirDown').css('display','none');
		}
		
		f = setTimeout(function clearBaloons(){$(".baloon").fadeOut(100)},1000);
	}
	
	scrollToPage = function(pagenr,subpagenr,sec,type) {
		posX = pagenr * -deviceWidth;
		posY = subpagenr * -deviceHeight;
		
		loadNextChapter(pagenr.split('-')[0])
		loadNextChapter(parseInt(pagenr.split('-')[0])+1)
		loadNextChapter(pagenr.split('-')[0]-1)
		if(type=='slide'){
			that[0].style.WebkitTransition = 'all '+sec+'s ease-in-out'
			that[0].style.WebkitTransform = "translate3d("  + posX + "px,"  + posY + "px,0)"
			that[0].style.msTransition = 'all '+sec+'s ease-in-out'
			that[0].style.msTransform = "translate(" + posX + "px, "+posY+"px)"	
			that[0].style.MozTransition = 'all '+sec+'s ease-in-out'
			that[0].style.MozTransform = "translate("  + posX + "px,"+posY+"px)"	
			that[0].style.OTransition = 'all '+sec+'s ease-in-out'
			that[0].style.OTransform = "translate(" + posX + "px,"+posY+"px)"
		}
		else if(type=='fade'){
			$('.pages').fadeOut(200,function(){
				that[0].style.WebkitTransform = "translate3d("  + posX + "px,"  + posY + "px,0)"
				that[0].style.msTransform = "translate(" + posX + "px, "+posY+"px)"
				that[0].style.MozTransform = "translate("  + posX + "px,"+posY+"px)"
				that[0].style.OTransform = "translate(" + posX + "px,"+posY+"px)"		
			}).fadeIn(200)			
		}
		else if(type=='load'){
			$('.pages').fadeOut(500,function(){
				$('#loading').css('display','block')
				that[0].style.WebkitTransform = "translate3d("  + posX + "px,"  + posY + "px,0)"
				that[0].style.msTransform = "translate(" + posX + "px, "+posY+"px)"
				that[0].style.MozTransform = "translate("  + posX + "px,"+posY+"px)"
				that[0].style.OTransform = "translate(" + posX + "px,"+posY+"px)"		
			}).delay(800).fadeIn(500,function(){
				$('#loading').css('display','none')
			});
		}
		
		currentPage = pagenr+1
		currentSubPage = subpagenr	
		clearSettings();
		
	}
	

	
	clearSettings = function(){
		$('#layer').css('display','none').unbind('click');
		$('#pageSettings').css('display','none');
		$('#magBar').css('display','none');
		$('#slogan').css('display','block');
		$('#subMenu').css({bottom:'-600px',left:0});	
		$('#subMenuTop').css({top:'-400px',left:0});	
		$('#subMenuLeft').css({left:'-300px',top:0});	
		$('#subMenuRight').css({right:'-300px',top:0});	
	}
	
	showSettings = function(){
		$('#pageSettings').css('display','block');
		$('#layer').css('display','block');
		
		$('#magBar').css('display','block');
		$('#slogan').css('display','none');
		//setBaloon(dirRight,dirLeft,dirUp,dirDown);
		//n = setTimeout("clearSettings()",5000);	
	}
	
	showSitemap = function(){

		html2canvas(document.body, {
			onrendered: function(canvas) {
				convertCanvasToImage(canvas);
			},
			width: 800,
			height: 1280
		});
		
		function convertCanvasToImage(canvas) {
			var image = new Image();
			image.src = canvas.toDataURL("image/png");
			$('#subMenu').append('<img src="'+image.src+'" width="200" />')
			return image;
		}
	}
	
	q = $('<div id="subMenu">&nbsp;<div style="position:absolute;right:30px;top:30px;font-size:2em;background-color:white;opacity:1;border-radius:0.4em;padding:0.5em;"><a href="javascript:void(0);" onclick="$(this).parent().parent().css(\'bottom\',\'-600px\');">X</a></div></div>');
	r = $('<div id="subMenuTop">&nbsp;<div style="position:absolute;right:30px;top:30px;font-size:2em;background-color:white;opacity:1;border-radius:0.4em;padding:0.5em;"><a href="javascript:void(0);" onclick="$(this).parent().parent().css(\'top\',\'-400px\');">X</a></div></div>');
	t = $('<div id="subMenuLeft">&nbsp;<div style="position:absolute;right:30px;top:30px;font-size:2em;background-color:white;opacity:1;border-radius:0.4em;padding:0.5em;"><a href="javascript:void(0);" onclick="$(this).parent().parent().css(\'left\',\'-300px\');">X</a></div></div>');
	u = $('<div id="subMenuRight">&nbsp;<div style="position:absolute;right:30px;top:30px;font-size:2em;background-color:white;opacity:1;border-radius:0.4em;padding:0.5em;"><a href="javascript:void(0);" onclick="$(this).parent().parent().css(\'right\',\'-300px\');">X</a></div></div>');
	
	//i = $('');void()
	$('.viewport').append(q);
	$('.viewport').append(r);
	$('.viewport').append(t);
	$('.viewport').append(u);
	$('#subMenu').css({
		position:'absolute',
		bottom:-600+'px',
		left:0,
		height:600+'px',
		width:'100%',
		backgroundColor: 'orange',
		color: 'white',
		zIndex:1005,
		opacity:0.6
	});
	$('#subMenuTop').css({
		position:'absolute',
		top:-400+'px',
		left: 0,
		height:400+'px',
		width:'100%',
		backgroundColor: 'steelblue',
		color: 'white',
		zIndex:1005,
		opacity:0.6
	});
	
	$('#subMenuLeft').css({
		position:'absolute',
		left:-300+'px',
		top: 0,
		height:'100%',
		width:'300px',
		backgroundColor: 'red',
		color: 'white',
		zIndex:1005,
		opacity:0.6
	});
	$('#subMenuRight').css({
		position:'absolute',
		top: 0,
		right:-300+'px',
		height:'100%',
		width:'300px',
		backgroundColor: 'olive',
		color: 'white',
		zIndex:1005,
		opacity:0.6
	});
	
	$('#slogan').click(function(){
		showSettings();
	});
	
	// auto Jump
	if(o.jumpTo != null && o.jumpTo != 'undefined'){
		scrollToPage(o.jumpTo.split('-')[0],o.jumpTo.split('-')[1],'0.6','load');
	}
	//loadNextChapter(currentPage+1)
	
	// ========================= EVENT HANDLING ============================
    
	// ------------------------- TOUCH-START / MOUSE-DOWN ------------------
	
    $('.pages').bind('touchstart.pageswipe mousedown.pageswipe keydown.pageswipe', function(event) {
      e = event.originalEvent
   
      scrollDirection = null
      
      pagesStartPosition = that.position().left
	  subPagesStartPosition = that.position().top
      
      touchDown = true
      
       if (e.type == 'keydown') {
        horizontalTouchStart = e.clientX
        verticalTouchStart = e.pageY
        
      } else if (e.type == 'mousedown') {
        horizontalTouchStart = e.clientX
        verticalTouchStart = e.pageY
        
      } else {
      
        horizontalTouchStart = e.touches[0].pageX
        verticalTouchStart = e.touches[0].pageY
        
      }      
	  
	  if(parseInt($('#subMenu').css('bottom')) == 0){
		$('#subMenu').css({
			bottom:-600,
			left:0
		})
	  }
	   if(parseInt($('#subMenuTop').css('top')) == 0){
		$('#subMenuTop').css({
			top:-400,
			left:0
		})
	  }
	  
	   if(parseInt($('#subMenuLeft').css('left')) == 0){
		$('#subMenuLeft').css({
			left:-300,
			top:0
		})
	  }
	  
	   if(parseInt($('#subMenuRight').css('right')) == 0){
		$('#subMenuRight').css({
			right:-300,
			top:0
		})
	  }
	  
	  
	  // check for directions
	 
	  

    })
    
	// ------------------------- TOUCH-MOVE / MOUSE-MOVE ------------------

	
    $('.pages').bind('touchmove.pageswipe mousemove.pageswipe', function(event) {
      
	
	event.preventDefault() 
	  
     if (!touchDown) {
        return true;
      }
	  
	  clearSettings();
      
      e = event.originalEvent
            
      if (e.type == 'keydown') {
        horizontalTouchPosition = e.clientX
      } else if (e.type == 'mousemove') {
        horizontalTouchPosition = e.clientX
      } else {
        horizontalTouchPosition = e.touches[0].pageX
      }
      
      horizontalTouchDelta = horizontalTouchPosition - horizontalTouchStart
            
      if (e.type == 'mousemove') {
        verticalTouchPosition = e.clientY
      } else {
        verticalTouchPosition = e.touches[0].pageY
      }
      
      verticalTouchDelta = verticalTouchPosition - verticalTouchStart
      
      if (horizontalTouchDelta > 0) {
        horizontalDirection = "right"
      } else if (horizontalTouchDelta < 1) {
        horizontalDirection = "left"
      }
	  
	   if (verticalTouchDelta > 0) {
        verticalDirection = "down"
      } else if (verticalTouchDelta < 1) {
        verticalDirection = "up"
      }
      
      selecting = false;
      
      if (window.getSelection) {
        if (window.getSelection().type == "Range") {
          selecting = true;
        }
      }
      
      if (!scrollDirection && !selecting) {
        /* We do not have a scrollDirection yet. So we are going to figure it
           out: */
        if (Math.abs(horizontalTouchDelta) > 10) {
          scrollDirection = "h"
        }
        
        if (Math.abs(verticalTouchDelta) > 10) {
          scrollDirection = "v"
        }
      }
	  
	  numberOfSubPages = $('.subpage',$('.page')[currentPage-1]).length
      
	
		z = 0;
		z2= 0;
		z3= 0;
		z4= 0;

      if (scrollDirection == "h") {
        if (e.preventDefault) {
          e.preventDefault() /* Disable other scroll directions when we are scrolling horizontally */
        }
		
        if(horizontalDirection == "right" && horizontalTouchStart < 50 && horizontalTouchDelta < 300 && horizontalTouchDelta > 0){
			z4 = 1;
			$('#subMenuLeft').css({
				left:-300+horizontalTouchDelta
			});
		}
		else if(horizontalDirection == "right" && horizontalTouchStart < 50 && horizontalTouchDelta > 0 ){
			
			z4 = 1;
			$('#subMenuLeft').css({
				left:0
			});
		}
		else if(horizontalDirection == "left" && horizontalTouchStart > breite-20 && horizontalTouchDelta > -300 && horizontalTouchDelta < 300){
			z3 = 1;
			
			$('#subMenuRight').css({
				right:-300-horizontalTouchDelta
			});
		}
		else if(horizontalDirection == "left" && horizontalTouchStart > breite-20 && horizontalTouchDelta < 0){
			z3 = 1;
			
			$('#subMenuRight').css({
				right:0
			});
		}
        else if ( 
          (horizontalDirection == "right" && currentPage > 1) || /* Make sure we cannot scroll to the left of the first page. */
          (horizontalDirection == "left" && currentPage < numberOfPages && z3 == 0 && z4 == 0) /* Make sure we cannot scroll beyond the last page. */
        ) {
			
			
		// if on subpage, clone the page and set it to the top, for smooth (but unlogic) sliding
		  //alert(parseInt($('#debugSubPage').html()));
		  v = parseInt($('#debugSubPage').html());
		  if(v > 0 && $('.clone').length==0){	
		  	if(v>1){
				x=v-1;}  
			else{
				x=0;}
			$('.subpage:eq('+x+')',$('.page')[currentPage-1]).clone().addClass('clone').css('z-index','9999').prependTo($('.page')[currentPage-1]);
		  }
			
			
          that[0].style.WebkitTransform = "translate3d(" + (pagesStartPosition + horizontalTouchDelta) + "px,0,0)"
          that[0].style.msTransform = "translate(" + (pagesStartPosition + horizontalTouchDelta) + "px, 0)"
          that[0].style.MozTransform = "translateX(" + (pagesStartPosition + horizontalTouchDelta) + "px)"
          that[0].style.OTransform = "translateX(" + (pagesStartPosition + horizontalTouchDelta) + "px)"
          
          if (jQuery.browser.version == "8.0") {
            that[0].style.left = (pagesStartPosition + horizontalTouchDelta)
			that[0].style.top = (subPagesStartPosition + verticalTouchDelta)
          }
        }
      }
	  //mrz 17/5/2013
	  /*z = 0;
	  z2= 0;*/
	  
	  if (scrollDirection == "v") {
     
		if (e.preventDefault) {
          e.preventDefault() /* Disable other scroll directions when we are scrolling vertically */
        }
		
		if(verticalDirection == "up" && verticalTouchStart > hoehe-110 && verticalTouchDelta > -600 && verticalTouchDelta < 0){
			z = 1;
			$('#subMenu').css({
				bottom:-600-verticalTouchDelta
			});
		}
		else if(verticalDirection == "up" && verticalTouchStart > hoehe-110 && verticalTouchDelta < -600 ){
			
			z = 1;
			$('#subMenu').css({
				bottom:0
			});
		}
		else if(verticalDirection == "down" && verticalTouchStart < 100 && verticalTouchDelta > -400 && verticalTouchDelta < 400){
			
			z2 = 1;
			$('#subMenuTop').css({
				top:-400+verticalTouchDelta
			});
		}
		else if(verticalDirection == "down" && verticalTouchStart < 100 && verticalTouchDelta > -400 && verticalTouchDelta >= 400){
			z2 = 1;
			$('#subMenuTop').css({
				top:0
			});
		}
        else if ( 
          ((verticalDirection == "down" && currentSubPage > 0) || /* Make sure we cannot scroll to the left of the first page. */
          (verticalDirection == "up" && currentSubPage < numberOfSubPages && numberOfSubPages > 0) && z == 0 && z2 == 0) /* Make sure we cannot scroll beyond the last page. */
        ) {
			
          that[0].style.WebkitTransform = "translate3d(" + pagesStartPosition + "px," + (subPagesStartPosition + verticalTouchDelta) + "px,0)"
          that[0].style.msTransform = "translate("+ pagesStartPosition + "px," + (subPagesStartPosition + verticalTouchDelta) + "px)"
          that[0].style.MozTransform = "translate("+ pagesStartPosition + "px," + (subPagesStartPosition + verticalTouchDelta) + "px)"
          that[0].style.OTransform = "translate("+ pagesStartPosition + "px," + (subPagesStartPosition + verticalTouchDelta) + "px)"
          
          if (jQuery.browser.version == "8.0") {
            that[0].style.top = (subPagesStartPosition + verticalTouchDelta)
			that[0].style.left =(horizontalTouchDelta)
          }
        }
      }
    })

	
	// ------------------------- TOUCH-END / MOUSE-UP ------------------
	
	$('.pages').bind('touchend.pageswipe mouseup.pageswipe keyup.pageswipe', function(event) {
		touchDown = false
		e = event.originalEvent
		
		if (e.type == 'keyup') {
			horizontalTouchEnd = e.pageX
			verticalTouchEnd = e.pageY
		} else if (e.type == 'mouseup') {
			horizontalTouchEnd = e.pageX
			verticalTouchEnd = e.pageY
		} else {
			horizontalTouchEnd = e.changedTouches[0].pageX
			verticalTouchEnd = e.changedTouches[0].pageY
		}
		
		horizontalTouchDelta = horizontalTouchStart - horizontalTouchEnd
		verticalTouchDelta = verticalTouchStart - verticalTouchEnd
		nextPositionV = 0
		nextPositionH = 0
		numberOfSubPages = $('.subpage',$('.page')[currentPage]).length
	 	
		z = 0
		z2 = 0
		z3 = 0
		z4 = 0
		goIntoCSSTransform = 1
		
		if (scrollDirection == "h") {
			if(parseInt($('#subMenuLeft').css('left')) > -290){
				
				$('#subMenuLeft').css({
					left:0
				})/*.unbind('touchstart,touchmove,tochend').bind('touchmove', function(e){
					e.stopImmediatePropagation()
				});*/
				z3 = 1
				goIntoCSSTransform = 0
			} else{
				
				$('#subMenuLeft').css({
					left:-300
				})
				z3 = 0;
				goIntoCSSTransform = 1
			}
			
			if(parseInt($('#subMenuRight').css('right')) > -300){
				
				$('#subMenuRight').css({
					right:0
				})/*.unbind('touchstart,touchmove,tochend').bind('touchmove', function(e){
					e.stopImmediatePropagation()
				});*/
				z4 = 1
				goIntoCSSTransform = 0
			} else{
				
				$('#subMenuRight').css({
					right:-300
				})
				z4 = 0;
				goIntoCSSTransform = 1
			}  
		
			if (horizontalTouchDelta < 175 && horizontalTouchDelta > -175 && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
			
				nextPositionH = (-deviceWidth * (currentPage-1))	
				nextPositionV = (-deviceHeight * (currentSubPage))	
				//alert(currentPage);
				that[0].style.WebkitTransition = 'all 0s ease-in-out'
				that[0].style.WebkitTransform = "translate3d("  + nextPositionH + "px,"+nextPositionV+"px,0)"
				
				that[0].style.msTransition = 'all 0s ease-in-out'
				that[0].style.msTransform = "translate(" + nextPositionH + "px, "+nextPositionV+"px)"
				
				that[0].style.MozTransition = 'all 0s ease-in-out'
				that[0].style.MozTransform = "translateX("  + nextPositionH + "px)"
				
				that[0].style.OTransition = 'all 0s ease-in-out'
				that[0].style.OTransform = "translateX(" + nextPositionH + "px)"
				
				} else if (horizontalTouchDelta > 175 && currentPage < numberOfPages && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
				nextPositionH = (-deviceWidth * (currentPage))
				nextPositionV = 0
				that[0].style.WebkitTransition = 'all 0s ease-in-out'
				that[0].style.WebkitTransform = "translate3d("  + nextPositionH + "px,0,0)"
				
				that[0].style.msTransition = 'all 0s ease-in-out'
				that[0].style.msTransform = "translate(" + nextPositionH + "px, 0)"
				
				that[0].style.MozTransition = 'all 0s ease-in-out'
				that[0].style.MozTransform = "translateX("  + nextPositionH + "px)"
				
				that[0].style.OTransition = 'all 0s ease-in-out'
				that[0].style.OTransform = "translateX(" + nextPositionH + "px)"
				
				if (jQuery.browser.version == "8.0") {
				that[0].style.left = nextPositionH
				that[0].style.top = nextPositionV
				}
				currentPage++
				currentSubPage = 0;
			} else if (horizontalTouchDelta < 175 && currentPage > 1 && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
				currentPage--
				nextPositionH = (-deviceWidth * (currentPage - 1))
				nextPositionV = 0
				that[0].style.WebkitTransition = 'all 0s ease-in-out'
				that[0].style.WebkitTransform = "translate3d("  + nextPositionH + "px,0,0)"
				
				that[0].style.msTransition = 'all 0s ease-in-out'
				that[0].style.msTransform = "translate(" + nextPositionH + "px, 0)"
				
				that[0].style.MozTransition = 'all 0s ease-in-out'
				that[0].style.MozTransform = "translateX("  + nextPositionH + "px)"
				
				that[0].style.OTransition = 'all 0s ease-in-out'
				that[0].style.OTransform = "translateX(" + nextPositionH + "px)"
				
				if (jQuery.browser.version == "8.0") {
				that[0].style.left = nextPositionH
				that[0].style.top = nextPositionV
				}
				currentSubPage = 0;
				
				
			} 
			if($('.clone').length){
			  $('.clone').remove();	 
			}
		
			// direction indicator
			// all 4 directions
			
			if(currentPage>1 && currentPage<numberOfPages){
				dirRight = 1
				dirLeft = 1
			}
			if(currentPage==1){
				dirRight = 1	
				dirLeft = 0
			}
			if(currentPage==numberOfPages){
				dirLeft = 1	
				dirRight = 0
			}
			if(currentSubPage>0 && currentSubPage<numberOfSubPages){
				dirUp = 1
				dirDown = 1
			}
			if(currentSubPage==0){
				dirDown = 1	
				dirUp = 0	
			}
			if(currentSubPage==numberOfSubPages && currentSubPage>0){
				dirUp = 1	
				dirDown = 0	
			}
			if(goIntoCSSTransform == 1){
				//setBaloon(dirRight,dirLeft,dirUp,dirDown);
			}	
			
			if(goIntoCSSTransform == 1){
				
				if(horizontalTouchDelta>0){
					nextPg = $('.page-'+(parseInt(currentPage)+1));
					if(nextPg.length > 0 && nextPg.html().indexOf('section')==-1){
						loadNextChapter(currentPage+1);	
					}	
				}
				else if(horizontalTouchDelta<0){
					nextPg = $('.page-'+(parseInt(currentPage)-1));
					if(nextPg.length > 0 && nextPg.length >0 && nextPg.html().indexOf('section')==-1){
						loadNextChapter(currentPage-1);	
					}	
				}			
				$('li','#sitemap').css('color','white');
				$('#smChapSubPage'+currentSubPage,'#smChap'+currentPage).css('color','red');	
				$('#sitemap').css({'display':'block','zIndex':9999}).center().delay(1000).fadeOut(100);			
			}
			
		//alert('HORIZITONAL SWIPE END \ncurrentPage: '+currentPage+'\nhorizontalDirection: '+horizontalDirection+'\ncurrentSubPage: '+currentSubPage+'\nnextPositionV: '+nextPositionV+'\nnumberOfSubPages: '+numberOfSubPages+' \nnextPositionH: '+nextPositionH);
		}
	
		numberOfSubPages = $('.subpage',$('.page')[currentPage-1]).length
		//mrz 17/5/2013
		z = 0
		z2 = 0
		z3 = 0
		z4 = 0
		goIntoCSSTransform = 1
		if (scrollDirection == "v") {
			//UP - scroll down content area
			
			/*console.log(verticalTouchDelta);
			console.log(currentSubPage);
			console.log(numberOfSubPages);
			console.log((-deviceWidth * (currentPage-1)));
			console.log((-deviceHeight * (currentSubPage+1)));
			console.log('---------------------------');*/
			if(parseInt($('#subMenu').css('bottom')) > -450){
				
				$('#subMenu').css({
					bottom:0
				})/*.unbind('touchstart,touchmove,tochend').bind('touchmove', function(e){
					e.stopImmediatePropagation()
				});*/
				//showSitemap();
				z = 1
				goIntoCSSTransform = 0
			} else{
				$('#subMenu').css({
					bottom:-600
				})
				z = 0;
				goIntoCSSTransform = 1
			}
			
			if(parseInt($('#subMenuTop').css('top')) > -300){
				
				$('#subMenuTop').css({
					top:0
				})/*.unbind('touchstart,touchmove,tochend').bind('touchmove', function(e){
					e.stopImmediatePropagation()
				});*/
				z2 = 1
				goIntoCSSTransform = 0
			} else{
				$('#subMenuTop').css({
					top:-400
				})
				z2 = 0;
				goIntoCSSTransform = 1
			}
			
			if (verticalTouchDelta < 175 && verticalTouchDelta > -175 && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
			
			nextPositionV = (-deviceHeight * (currentSubPage))
			 nextPositionH = (-deviceWidth * (currentPage-1))
			  //alert(currentPage);
			  that[0].style.WebkitTransition = 'all 0s ease-in-out'
			  that[0].style.WebkitTransform = "translate3d("+nextPositionH+"px,"  + nextPositionV + "px,0)"
			  
			  that[0].style.msTransition = 'all 0s ease-in-out'
			  that[0].style.msTransform = "translate("+nextPositionH+"px," + nextPositionV + "px)"
			  
			  that[0].style.MozTransition = 'all 0s ease-in-out'
			  that[0].style.MozTransform = "translateY("  + nextPositionV + "px)"
			  
			  that[0].style.OTransition = 'all 0s ease-in-out'
			  that[0].style.OTransform = "translateY(" + nextPositionV + "px)"
			  
			} else if (verticalTouchDelta > 175 && currentSubPage < numberOfSubPages && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
			 
			  nextPositionV = (-deviceHeight * (currentSubPage+1))
			  nextPositionH = (-deviceWidth * (currentPage-1))
			  
			  that[0].style.WebkitTransition = 'all 0s ease-in-out'
			  that[0].style.WebkitTransform = "translate3d(" + nextPositionH + "px," + nextPositionV + "px,0)"
			  
			  that[0].style.msTransition = 'all 0s ease-in-out'
			  that[0].style.msTransform = "translate(" + nextPositionH + "px," + nextPositionV + "px)"
			  
			  that[0].style.MozTransition = 'all 0s ease-in-out'
			  that[0].style.MozTransform = "translate("+ nextPositionH + "px,"  + nextPositionV + "px)"
			  
			  that[0].style.OTransition = 'all 0s ease-in-out'
			  that[0].style.OTransform = "translate("+ nextPositionH + "px," + nextPositionV + "px)"
			  
			  if (jQuery.browser.version == "8.0") {
				that[0].style.top = nextPositionV
				that[0].style.left = nextPositionH
			  }
			 
			  currentSubPage++
			 
				
			  //DOWN
			} else if (verticalTouchDelta < 175 && currentSubPage > 0 && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
			
			  currentSubPage--
			  nextPositionV = (-deviceHeight * (currentSubPage))
			  nextPositionH = (-deviceWidth * (currentPage-1))
			  
			  that[0].style.WebkitTransition = 'all 0s ease-in-out'
			  that[0].style.WebkitTransform = "translate3d("  + nextPositionH + "px," + nextPositionV + "px,0)"
			  
			  that[0].style.msTransition = 'all 0s ease-in-out'
			  that[0].style.msTransform = "translate(" + nextPositionH + "px," + nextPositionV + "px)"
			  
			  that[0].style.MozTransition = 'all 0s ease-in-out'
			  that[0].style.MozTransform = "translate("  + nextPositionH + "px,"+nextPositionV + "px)"
			  
			  that[0].style.OTransition = 'all 0s ease-in-out'
			  that[0].style.OTransform = "translate("+ nextPositionH + "px," + nextPositionV + "px)"
			  
			  if (jQuery.browser.version == "8.0") {
				 that[0].style.top = nextPositionV
				 that[0].style.left = nextPositionH
			  }
			 
			}
			// direction indicator
			// all 4 directions
			
			if(currentPage>1 && currentPage<numberOfPages){
				dirRight = 1
				dirLeft = 1
			}
			if(currentPage==1){
				dirRight = 1	
				dirLeft = 0
			}
			if(currentPage==numberOfPages){
				dirLeft = 1	
				dirRight = 0
			}
			if(currentSubPage>0 && currentSubPage<numberOfSubPages){
				dirUp = 1
				dirDown = 1
			}
			if(currentSubPage==0){
				dirDown = 1	
				dirUp = 0	
			}
			if(currentSubPage==numberOfSubPages && currentSubPage>0){
				dirUp = 1	
				dirDown = 0	
			}
			
			if(goIntoCSSTransform == 1){
				//setBaloon(dirRight,dirLeft,dirUp,dirDown);
				$('li','#sitemap').css('color','white');
				$('#smChapSubPage'+currentSubPage,'#smChap'+currentPage).css('color','red');	
				$('#sitemap').css({'display':'block','zIndex':9999}).center().delay(1000).fadeOut(100);			
			}
			
			//alert('VERTICAL SWIPE END\ncurrentPage: '+currentPage+'\nhorizontalDirection: '+verticalDirection+'\ncurrentSubPage: '+currentSubPage+'\nnextPositionV: '+nextPositionV+'\nnumberOfSubPages: '+numberOfSubPages+' \nnextPositionH: '+nextPositionH);
		}

		numberOfSubPages = $('.subpage',$('.page')[currentPage-1]).length
		$('#debugPage').html(currentPage); // + '/'+ numberOfPages + ' - Subpage: '+ currentSubPage + '/' + numberOfSubPages);
		$('#debugPages').html(numberOfPages);
		$('#debugSubPage').html(currentSubPage);
		$('#debugSubPages').html(numberOfSubPages);
		cr = currentPage-1
		$('#debugChapter').html($('.page:eq('+cr+')').attr('title')); 
		cr2 = currentSubPage;
		a = $('.page:eq('+cr+')');
		if(cr2==0){
		b = 'section';
		}
		else{
		  b = "'.subpage:eq("+(cr2-1)+")'" ;
		}
		//alert(b);
		st = $(b,a).attr('title');
		$('#debugPageTitle').html(st);
		
		
    })
 
    return this 
  };
})( jQuery )
