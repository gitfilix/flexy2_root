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
		vpWidth: $(window).width(), //not manadatory
		vpHeight: $('.content').height(), //not manadatory
		//initAjaxFile: '', //path to initial-file of the mag, mandatory
		playAudioJingle: '', //path to mp3-file, not mandatory
		jumpTo: '0-0',
		jumpToType: 'fade', // fade, slide, load
		initOri: 1,
		initDevice: 'ipad',
		swipable: false,
		keys: false,
		transfade: false,
		customDirections: false
	}
	
	var options =  $.extend(defaults, options);
	var o = options;
	var os = "notIOS";	
	if(navigator.userAgent.match(/(iPhone|iPod|iPad)/i)){
		os = "ios"
	}
	
	var viewportHeight = o.vpHeight;
	var deviceWidth = o.vpWidth;
	var deviceHeight = $('.content').height();
	
    if (viewportHeight > deviceHeight) {
      remaining = viewportHeight - deviceHeight
      remainingHeight = (remaining / 2) + 'px '
      viewportHeight = deviceHeight
    } else {
      remainingHeight = ''  
    }
    
    pageswipe_viewport = $('<div class="pageswipe-viewport viewport"></div>')
    pageswipe_viewport.css({height: viewportHeight + 'px', width: deviceWidth + 'px', margin: remainingHeight + 'auto', overflow: "hidden", position: "relative"})
    this.wrap(pageswipe_viewport)

	var numberOfPages = this.children('.page').length
    
    this.css({width: (numberOfPages * deviceWidth) + "px", position: "absolute"})
    this.children('.page').css({width: deviceWidth + 'px', "float": "left", "overflow-y": "hidden", "position": "relative"}) //"-webkit-overflow-scrolling": "touch", 
    
	//mrz 17/05/2013
	this.find('.subpage').css({width: deviceWidth + 'px', height: deviceHeight + 'px', "overflow-y": "hidden", "-webkit-overflow-scrolling": "touch"});
	this.find('section').css({height: deviceHeight + 'px',width: deviceWidth + 'px',"overflow-y": "hidden",  "-webkit-overflow-scrolling": "touch"});
	
	//$(".coverflow").flipster();
	//$(".coverflow").unbind('touchmove')
	
	var that = this
    var pagesStartPosition = 0
	var subPagesStartPosition = 0
    var horizontalTouchStart = null
    var verticalTouchStart = null
    var scrollDirection = null
    var currentPage = o.jumpTo.split('-')[0]
	var currentSubPage = o.jumpTo.split('-')[1]
    var touchDown = false
	
	var dirRight = 0
	var dirLeft = 0
	var dirUp = 0
	var dirDown = 0
	
	var allowedDirs = '0,0,0,0'
	var allowedTop = 0
	var allowedRight = 0
	var allowedBottom = 0
	var allowedLeft = 0

	var numberOfSubPages = numberOfSubPages = $('.subpage',$('.page')[0]).length

	if((window.orientation == 90 || window.orientation == -90) && os == 'notIOS'){
		var breite = $(window).width()	
		var hoehe = $(window).height()	
	
		
	}
	else if(os == 'notIOS'){
		var breite = $(window).width()	
		var hoehe = $(window).height()	
		
	}
	else if(os == 'ios'){
		var breite = $(window).width()	
		var hoehe = $(window).height()
	}
	
	$('#debugPage').html(1); // + '/'+ numberOfPages + ' - Subpage: '+ currentSubPage + '/' + numberOfSubPages);
	$('#debugPages').html(numberOfPages-1);
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
	
	playAudioJingle = function(pathToFile){
		audio = $('<div id="bgAudio"><audio autoplay><source src="'+pathToFile+'"></audio></div>')	
		$('body').append($(audio));	
		//$('audio')[0].play();
	}
	
	if(o.playAudioJingle!=''){
		playAudioJingle(o.playAudioJingle);
	}
	
	
	toggleAudioPlay = function() {
        var a = $('audio')[0]
		var play = a.paused; //default to paused.
        if (play==false) {
            a.pause();
        }
        else {
            a.play();
        }
    }
	
	
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
		$.get('/felix/ajax_magPage.cfm',{chapterNr:chapterNr,orientation:$('body').attr('class').split(' ')[1],device:$('body').attr('class').split(' ')[0]},function(returnData){
			$('.page-'+chapterNr).html(returnData);
			$('.layoutElem').each(function(){
				if($(this).hasOverflow()){
					$(this).addClass('overflowed');
					//alert(1)
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
					'href':'/felix/ajax_article.cfm?flexyCmsArticleID=1&width=80%&height=80%'
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
	
	deInitSlide = function(cp,csp){
		//$('video')[0].pause()
	}
	
	initSlide = function(cp,csp){
		// get actual Slide	
		// if top chapterSlide
		if(csp==0){
			currentSlide = $('section','.page-'+cp)
		}
		// if subSlide
		else{
			currentSlide = $('.subpage-'+cp+'-'+csp)
		}
		
		 // check allowed directions
		if(o.customDirections==true){
			allowedDirs = currentSlide.data('alloweddirections') 
			allowedTop = allowedDirs.split(',')[0]
			allowedRight = allowedDirs.split(',')[1]
			allowedBottom = allowedDirs.split(',')[2]
			allowedLeft = allowedDirs.split(',')[3]
		}
		else{
			allowedTop = 1
			allowedRight = 1
			allowedBottom = 1
			allowedLeft = 1
		}
		if(cp>0 && cp<numberOfPages-1){
			dirRight = 1
			dirLeft = 1
		}
		if(cp==0){
			dirRight = 1	
			dirLeft = 0
		}
		if(cp==numberOfPages-1){
			dirLeft = 1	
			dirRight = 0
		}
		if(csp>0 && csp<numberOfSubPages){
			dirUp = 1
			dirDown = 1
		}
		if(csp==0){
			dirDown = 1	
			dirUp = 0	
		}
		if(csp==numberOfSubPages && csp>0){
			dirUp = 1	
			dirDown = 0	
		}
		
		//depending on allowed directions
		if(o.customDirections==true){
			if(allowedLeft==0){
				dirLeft = 0
			}
			if(allowedRight==0){
				dirRight = 0
			}
			if(allowedBottom==0){
				dirDown = 0
			}
			if(allowedTop==0){
				dirUp = 0
			}
		}
		setBaloon(dirRight,dirLeft,dirUp,dirDown);
		
		
		
		// VIDEO
		$('video',currentSlide).each(function(idx){
			_this = $(this);
			
			attrAutobuffer = _this.attr('autobuffer');
			attrControls = _this.attr('controls');
			attrAutoplay = _this.attr('autoplay');
			
			
			newVideoTag = $('<video/>', {
				id: 'video'+idx,
				html         : $('<source />', {
					'src'    : 'https://s3.amazonaws.com/s3hub-1b3c58271cb3e0dfa49d60cae0ac8b86ade30aed6294bdb5fe682e2bf/HTML5/sintel_trailer-480.mp4',
					'type'   : 'video/mp4'       
				}),
				css:	({
					width:_this.width(),
					display:'none',
					'margin-left': _this.css('margin-left'),
					'margin-top': _this.css('margin-top'),
					position:_this.css('position'),
					height: _this.height(),
					'background-color': _this.css('background-color')
				})
			});
			
			if (typeof attrAutobuffer !== 'undefined' && attrAutobuffer !== false) {
				newVideoTag.attr('autobuffer',attrAutobuffer)
			}
			if (typeof attrControls !== 'undefined' && attrControls !== false) {
				newVideoTag.attr('controls',attrControls)
			}
			if (typeof attrAutoplay !== 'undefined' && attrAutoplay !== false) {
				newVideoTag.attr('autoplay',attrAutoplay)
			}
		
			newVideoTag.appendTo(currentSlide).fadeIn();
			_this.remove();
		});
		 	
			
	}
	
	setBaloon = function(right,left,up,down){
		if(right==1){	
			$('#dirRight').css({
				top: (hoehe / 2) - ($('#dirRight').width()/2)+75,
				display: 'block'
			});
			chapter = $('.page-'+(currentPage+1)).attr('title')
			$('span','#dirRight').html('<br/>' + chapter)
		}else{
			$('#dirRight').css('display','none');
		}
		if(left==1){
			$('#dirLeft').css({
				top: (hoehe / 2) - ($('#dirLeft').width()/2)+75,
				display: 'block'
			});
			chapter = $('.page-'+(currentPage-1)).attr('title')
			$('span','#dirLeft').html('<br/>' + chapter)
		}else{
			$('#dirLeft').css('display','none');
		}
		if(up==1){
			$('#dirUp').css({
				left: (breite / 2) - ($('#dirUp').width()/2),
				display: 'block'
			});
			if(currentSubPage-1==0){	
				chapter = $('.page-'+currentPage).attr('title')
			}
			else{
				chapter = $('.subpage-'+currentPage+'-'+(currentSubPage-1)).attr('title')
			}
			$('span','#dirUp').html('<br/>' + chapter)
		}else{
			$('#dirUp').css('display','none');
		}
		if(down==1){
			$('#dirDown').css({
				left: (breite / 2) - ($('#dirDown').width()/2),
				display: 'block'
			});
			chapter = $('.subpage-'+currentPage+'-'+(currentSubPage+1)).attr('title')
			$('span','#dirDown').html('<br/>' + chapter)
		}else{
			$('#dirDown').css('display','none');
		}
		
		f = setTimeout(function clearBaloons(){$(".baloon").stop().fadeOut(100)},1000);
	}
	
	scrollToPage = function(pagenr,subpagenr,sec,type) {
		posX = pagenr * -$(window).width();
		posY = subpagenr * -$('.content').height();
		deInitSlide(currentPage,currentSubPage);
		//loadNextChapter(pagenr)
		//loadNextChapter(parseInt(pagenr)+1)
		//loadNextChapter(pagenr-1)
		if(type=='slide'){

			that[0].style.WebkitTransform = "translate3d("  + posX + "px,"  + posY + "px,0)"
			that[0].style.msTransition = 'all '+sec+'s linear'
			that[0].style.msTransform = "translate(" + posX + "px, "+posY+"px)"	
			that[0].style.MozTransition = 'all '+sec+'s linear'
			that[0].style.MozTransform = "translate("  + posX + "px,"+posY+"px)"	
			that[0].style.OTransition = 'all '+sec+'s linear'
			that[0].style.OTransform = "translate(" + posX + "px,"+posY+"px)"
		}
		else if(type=='fade'){
			$('.pages').fadeOut(sec*1000,function(){
				that[0].style.WebkitTransform = "translate3d("  + posX + "px,"  + posY + "px,0)"
				that[0].style.msTransform = "translate(" + posX + "px, "+posY+"px)"
				that[0].style.MozTransform = "translate("  + posX + "px,"+posY+"px)"
				that[0].style.OTransform = "translate(" + posX + "px,"+posY+"px)"		
			}).fadeIn(sec*1000)			
		}
		else if(type=='load'){
			$('.pages').fadeOut(sec*1000,function(){
				$('#loading').css('display','block')
				that[0].style.WebkitTransform = "translate3d("  + posX + "px,"  + posY + "px,0)"
				that[0].style.msTransform = "translate(" + posX + "px, "+posY+"px)"
				that[0].style.MozTransform = "translate("  + posX + "px,"+posY+"px)"
				that[0].style.OTransform = "translate(" + posX + "px,"+posY+"px)"		
			}).delay(100).fadeIn(sec*1000,function(){
				$('#loading').fadeOut(sec*1000)
			});
		}	
		currentPage = parseInt(pagenr)
		currentSubPage = subpagenr	
		
		clearSettings();	
		transFadeBg(currentPage+'-'+currentSubPage);
		initSlide(currentPage,currentSubPage);
		//currentPage = o.jumpTo.split('-')[0]
		//currentSubPage = o.jumpTo.split('-')[1]
		/*numberOfSubPages = $('.subpage',$('.page')[currentPage]).length
		$('#debugPage').html(currentPage); // + '/'+ numberOfPages + ' - Subpage: '+ currentSubPage + '/' + numberOfSubPages);
		$('#debugSubPage').html(currentSubPage);
		$('#debugSubPages').html(numberOfSubPages);
		$('#debugChapter').html($('.page:eq(currentPage)').attr('title'));
		$('#debugPageTitle').html($('section:eq(currentPage)').attr('title'));
		*/
		afterSlide();
		
	}

	clearSettings = function(){
		$('#layer').fadeOut();
		$('#pageSettings').css('display','none');
		$('#magBar').css('display','none');
		$('#slogan').css('display','block');
		$('#subMenu').css({bottom:'-300px',left:0});	
		$('#subMenuTop').css({top:'-300px',left:0});	
		$('#subMenuLeft').css({left:'-300px',top:0});	
		$('#subMenuRight').css({right:'-300px',top:0});	
		$('.pages').css({
			opacity: 1
		})
	}
	
	showSettings = function(){
		$('#pageSettings').css('display','block');
		$('#layer').slideToggle();
		
		//$('#magBar').css('display','block');
		//$('#slogan').css('display','none');
		//setBaloon(dirRight,dirLeft,dirUp,dirDown);
		//n = setTimeout("clearSettings()",5000);	
	}
	
	showSlideInPanel = function(dir){
		if($('#subMenuLeft').css('left')=='0px'){
			$('#subMenuLeft').animate({
				left:-300
			})
		}
		else{
			$('#subMenuLeft').animate({
				left:0
			})	
		}	
	}
		
	doOnOrientationChange = function doOnOrientationChange(){
		/*$('.viewport').css('height',$('.content').height());
		$('.viewport').css('width',$(window).width());
		$('.pages').css('width',numberOfPages * $(window).width());
		$('.section,.subpage').css('height',$('.content').height());
		$('.page,section,.subpage').css('width',$(window).width());*/
		$("body").removeAttr('class');
		$(window).unbind();
		$('audio').remove();
		$('body').unbind();
		$('*').unbind();
		$('.viewport').remove;
		r = $('<div class="pages"></div><div id="bg1">&nbsp;</div><div id="bg2">&nbsp;</div>')
		$('#scrollable2').html(r)
		//console.clear();
		//console.log(currentPage + '-'+currentSubPage)
		loadMag(currentPage + '-' + (parseInt(currentSubPage)))	
		$('#debugPage').html(currentPage); // + '/'+ numberOfPages + ' - Subpage: '+ currentSubPage + '/' + numberOfSubPages);
		$('#debugPages').html(numberOfPages);
		$('#debugSubPage').html(currentSubPage);
		$('#debugSubPages').html(numberOfSubPages);
		cr = currentPage
		$('#debugChapter').html($('.page:eq('+cr+')').attr('title')); 
		/*rtime = new Date(1, 1, 2000, 12,00,00);
		timeout = false;
		delta = 200;*/
		
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
	
	preloadAllBgImages = function(){
		img = new Array(1)
		$('section,.subpage').each(function(idx){
			img[idx] = new Image();
			img[idx].src = $(this).data('bgimg')
			if(o.transfade == false && $(this).data('bgimg') != ''){
				$(this).css({
					'background':'transparent url("'+img[idx].src+'") left top no-repeat',
					'background-size':'100% 100%'
				});	
			}
		});
	}
	
	transFadeBg = function(page){
		if(o.transfade == true){	
			s = 750;
			if(screen.width<=767 ){
				s = 0
			}		
			// ----------------------------------------------	
			if(page.split('-')[1]==0){
				c = $('section',$('.page')[parseInt(page.split('-')[0])]).data('bgimg')
				v = $('section',$('.page')[parseInt(page.split('-')[0])]).data('bgvid')
			}
			else{
				c = $('.subpage-'+page.split('-')[0]+'-'+page.split('-')[1]).data('bgimg');	
				v = $('.subpage-'+page.split('-')[0]+'-'+page.split('-')[1]).data('bgvid');	
			}
			
			if(($('#bg1').css('background-image').indexOf('/')>-1 && c != '') || ($('#vid','#bg1').length>0 || $('.videoBG','#bg1').length>0)){
				origBG = $('#bg1')
				oppBG = $('#bg2')	
			}
			else if(($('#bg2').css('background-image').indexOf('/')>-1 && c != '') || ($('#vid','#bg2').length>0 || $('.videoBG','#bg2').length>0)){
				origBG = $('#bg2')
				oppBG = $('#bg1')	
			}
			else{
				origBG = $('#bg1')
				oppBG = $('#bg2')	
			}			
			// wenn videobg der aktuellen seite
			if(v!=''){
				origBG.fadeOut(s,function(){
					$(this).removeAttr('style')
					$(this).empty()
				})	
				if(os != 'ios'){
					oppBG.videoBG({
						position:"fixed",
						zIndex:-1,
						mp4:v,
						ogv:v,
						webm:v,
						poster:'',
						opacity:1
					});
					oppBG.fadeIn()
				}
				else{
					oppBG.css({
						'display': 'none',
						'background': 'transparent url("'+c+'") left top no-repeat',
						'background-attachment': 'fixed',
						'background-size': '100% 100%',
						'overflow':'hidden'
					}).html('<video id="vid" width="100%" muted loop height="100%" style="width:100%;height:100%;"><source type="video/mp4" src="'+v+'"></source></video>').fadeIn(s,function(){
						origBG.css({
							'background-image': 'none',
							overflow:'hidden'
						})	
					})	
					$('#vid')[0].play()
					$("#vid")[0].volume = 0;
				}
				console.log('video-bg, bg-img on bg2')
			}
			
			// wenn KEIN videobg
			else{	
				origBG.fadeOut(s,function(){
					$(this).removeAttr('style')
					$(this).empty()
				})	
				oppBG.hide().css({
					'background': 'transparent url("'+c+'") left top no-repeat',
					'background-attachment': 'fixed',
					'background-size': '100% 100%'
				}).fadeIn(s,function(){
					origBG.empty().css({
						'background': 'none',
					})	
				})	
				console.log('no video-bg, horizontal, bg-img on bg2')		
			}
			// ----------------------------------------------
		}
		// for videobg in slide-mode without transfade
		else{
			if(page.split('-')[1]==0){
				c = $('section',$('.page')[parseInt(page.split('-')[0])]).data('bgimg')
				v = $('section',$('.page')[parseInt(page.split('-')[0])]).data('bgvid')
			}
			else{
				c = $('.subpage-'+page.split('-')[0]+'-'+page.split('-')[1]).data('bgimg');	
				v = $('.subpage-'+page.split('-')[0]+'-'+page.split('-')[1]).data('bgvid');	
			}
			if(($('#bg1').css('background-image').indexOf('/')>-1 && c != '') || ($('#vid','#bg1').length>0 || $('.videoBG','#bg1').length>0)){
				origBG = $('#bg1')
				oppBG = $('#bg2')	
			}
			else if(($('#bg2').css('background-image').indexOf('/')>-1 && c != '') || ($('#vid','#bg2').length>0 || $('.videoBG','#bg2').length>0)){
				origBG = $('#bg2')
				oppBG = $('#bg1')	
			}
			else{
				origBG = $('#bg1')
				oppBG = $('#bg2')	
			}	
			
			if(v!=''){	
				if(os != 'ios'){
					if(page.split('-')[1]==0){
						$('section',$('.page')[parseInt(page.split('-')[0])]).css('background','none')
					}
					else{
						$('.subpage-'+page.split('-')[0]+'-'+page.split('-')[1]).css('background','none')
					}
					
					$('#bg2').fadeOut(250,function(){
						$(this).removeAttr('style')
						$(this).empty()
						$('#bg2').hide().videoBG({
							position:"fixed",
							zIndex:-1,
							mp4:v,
							ogv:v,
							webm:v,
							poster:'',
							opacity:1
						});
						$('#bg2').fadeIn()
					})	
					
					
				}
				else{
					if(page.split('-')[1]==0){
						$('section',$('.page')[parseInt(page.split('-')[0])]).css({
							'background':'none',
							'background':'transparent'
						});
					}
					else{
						$('.subpage-'+page.split('-')[0]+'-'+page.split('-')[1]).css({
							'background':'none',
							'background':'transparent'
						})
					}
					
					
					if(($('#bg1').css('background-image').indexOf('/')>-1 && c != '') || ($('#vid','#bg1').length>0 || $('.videoBG','#bg1').length>0)){
						
					}
					else if(($('#bg2').css('background-image').indexOf('/')>-1 && c != '') || ($('#vid','#bg2').length>0 || $('.videoBG','#bg2').length>0)){
						
					}
					
					
					$('#bg2').css({
						'background': 'transparent url("'+c+'") left top no-repeat',
						'background-attachment': 'fixed',
						'background-size': '100% 100%',
						'overflow':'hidden'
					}).html('<video id="vid" width="100%" muted loop height="100%" style="width:100%;height:100%;"><source type="video/mp4" src="'+v+'"></source></video>').fadeIn(300,function(){
						$('#bg2').css({
							'background-image': 'none',
							overflow:'hidden'
						})	
					})	
					$('#vid')[0].play()
					$("#vid")[0].volume = 0;
				}		
			}
			else{
				if(($('#bg1').css('background-image').indexOf('/')>-1 && c != '') || ($('#vid','#bg1').length>0 || $('.videoBG','#bg1').length>0)){
					if(page.split('-')[1]==0){	
						c = $('section',$('.page')[parseInt(page.split('-')[0])]).data('bgimg')
					}
					else{
						c = $('.subpage:eq('+parseInt(page.split('-')[1]-1)+')',$('.page')[parseInt(page.split('-')[0])]).data('bgimg')
					}
					$('#bg1').fadeOut(250,function(){
						$(this).removeAttr('style')
						$(this).empty()
					})	
					$('#bg1').css({
						'display': 'none',
						'background': 'transparent url("'+c+'") left top no-repeat',
						'background-attachment': 'fixed',
						'background-size': '100% 100%'
					}).fadeIn(250,function(){
						$('#bg2').css({
							'background-image': 'none',
						})	
					})	
				}
				else if(($('#bg2').css('background-image').indexOf('/')>-1 && c != '') || ($('#vid','#bg2').length>0 || $('.videoBG','#bg2').length>0)){
					if(page.split('-')[1]==0){	
						c = $('section',$('.page')[parseInt(page.split('-')[0])]).data('bgimg')
					}
					else{
						c = $('.subpage:eq('+parseInt(page.split('-')[1]-1)+')',$('.page')[parseInt(page.split('-')[0])]).data('bgimg')
					}
					$('#bg2').fadeOut(250,function(){
						$(this).removeAttr('style')
						$(this).empty()
					})	
					$('#bg2').css({
						'display': 'none',
						'background': 'transparent url("'+c+'") left top no-repeat',
						'background-attachment': 'fixed',
						'background-size': '100% 100%'
					}).fadeIn(250,function(){
						$('#bg1').css({
							'background-image': 'none',
						})	
					})	
				}
			}
		}
	}
	
	q = $('<div id="subMenu">&nbsp;<div style="position:absolute;right:30px;top:30px;font-size:2em;background-color:white;opacity:1;border-radius:0.4em;padding:0.5em;"><a href="javascript:void(0);" onclick="$(this).parent().parent().css(\'bottom\',\'-300px\');$(\'#subMenuTop\').css(\'top\',\'-300px\');$(\'.pages\').css(\'opacity\',\'1\')">X</a></div></div>');
	r = $('<div id="subMenuTop"><div style="text-align:center;padding-top:10px;"><img src="/felix/music-app/img/spalshLogo.jpg" /></div></div>'); //<div style="position:absolute;right:30px;top:30px;font-size:2em;background-color:white;opacity:1;border-radius:0.4em;padding:0.5em;"><a href="javascript:void(0);" onclick="$(this).parent().parent().css(\'top\',\'-300px\');">X</a></div>
	t = $('<div id="subMenuLeft"><div id="chapterNav" class="nomobile"></div><div style="position:absolute;right:30px;top:30px;font-size:2em;background-color:white;opacity:1;border-radius:0.4em;padding:0.5em;"><a href="javascript:void(0);" onclick="$(this).parent().parent().css(\'left\',\'-300px\');">X</a></div></div>');
	u = $('<div id="subMenuRight">&nbsp;<div style="position:absolute;right:0px;top:10px;font-size:2em;z-index:999;background-color:white;opacity:1;border-radius:0.4em;padding:0.5em;"><a href="javascript:void(0);" onclick="$(this).parent().parent().css(\'right\',\'-300px\');">X</a></div></div>');
	
	//i = $('');void()
	$('.viewport').append(q);
	$('.viewport').append(r);
	$('.viewport').append(t);
	$('.viewport').append(u);

	swipableSitemapLoaded = function(){
		myScrollSitemap = new iScroll('siteMapWrapper',{
			snap: true,
			desktopCompatibility: true,
			momentum: false,
			zoom: false,
			hScrollbar: true,
			wheelAction: 'true',
			vScrollbar: false,
			checkDOMChanges: false
		});
		
		
		
		myScrollSitemap0 = new iScroll('siteMapSubWrapper0',{
			snap: 'li',
			desktopCompatibility: false,
			momentum: true,
			zoom: false,
			hScrollbar: false,
			wheelAction: 'false',
			vScrollbar: false,
			checkDOMChanges: false
		});
		myScrollSitemap1 = new iScroll('siteMapSubWrapper1',{
			snap: 'li',
			desktopCompatibility: false,
			momentum: true,
			zoom: false,
			hScrollbar: false,
			wheelAction: 'false',
			vScrollbar: false,
			checkDOMChanges: false
		});
		myScrollSitemap2 = new iScroll('siteMapSubWrapper2',{
			snap: 'li',
			desktopCompatibility: false,
			momentum: true,
			zoom: false,
			hScrollbar: false,
			wheelAction: 'false',
			vScrollbar: false,
			checkDOMChanges: false
		});
		myScrollSitemap3 = new iScroll('siteMapSubWrapper3',{
			snap: 'li',
			desktopCompatibility: false,
			momentum: true,
			zoom: false,
			hScrollbar: false,
			wheelAction: 'false',
			vScrollbar: false,
			checkDOMChanges: false
		});
		
		
	}
	
	swipableSitemapLoadedB = function(){
		myScrollSitemapB = new iScroll('siteMapWrapperB',{
			snap: false,
			desktopCompatibility: true,
			momentum: true,
			zoom: false,
			hScrollbar: true,
			wheelAction: 'true',
			vScrollbar: true,
			checkDOMChanges: false
		});
		
	}
	
	swipableSitemapLoadedA = function(){
		myScrollSitemapA = new iScroll('siteMapWrapperA',{
			snap: true,
			desktopCompatibility: true,
			momentum: false,
			zoom: false,
			hScrollbar: true,
			wheelAction: 'true',
			vScrollbar: false,
			checkDOMChanges: false
		});
		myScrollSitemap0A = new iScroll('siteMapSubWrapper0A',{
			snap: 'li',
			desktopCompatibility: false,
			momentum: true,
			zoom: false,
			hScrollbar: false,
			wheelAction: 'false',
			vScrollbar: true,
			checkDOMChanges: false
		});
		myScrollSitemap1A = new iScroll('siteMapSubWrapper1A',{
			snap: 'li',
			desktopCompatibility: false,
			momentum: true,
			zoom: false,
			hScrollbar: false,
			wheelAction: 'false',
			vScrollbar: false,
			checkDOMChanges: false
		});
		myScrollSitemap2A = new iScroll('siteMapSubWrapper2A',{
			snap: 'li',
			desktopCompatibility: false,
			momentum: true,
			zoom: false,
			hScrollbar: false,
			wheelAction: 'false',
			vScrollbar: false,
			checkDOMChanges: false
		});
		myScrollSitemap3A = new iScroll('siteMapSubWrapper3A',{
			snap: 'li',
			desktopCompatibility: false,
			momentum: true,
			zoom: false,
			hScrollbar: false,
			wheelAction: 'false',
			vScrollbar: false,
			checkDOMChanges: false
		});	
	}
	
	afterSlide = function(){
		numberOfSubPages = $('.subpage',$('.page')[currentPage]).length
		$('#debugPage').html(currentPage); // + '/'+ numberOfPages + ' - Subpage: '+ currentSubPage + '/' + numberOfSubPages);
		$('#debugPages').html(numberOfPages-1);
		$('#debugSubPage').html(currentSubPage);
		$('#debugSubPages').html(numberOfSubPages);
		cr = currentPage
		$('#debugChapter').html($('.page:eq('+cr+')').attr('title')); 
		cr2 = currentSubPage;
		a = $('.page-'+cr);
		if(cr2==0){
			
		}
		else{
			a = ".subpage-"+cr+"-"+cr2 ;
		}
		//alert(b);
		st = $(a).attr('title');
		$('#debugPageTitle').html(st);
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
			bottom:-300,
			left:0
		})
	  }
	   if(parseInt($('#subMenuTop').css('top')) == 0){
		$('#subMenuTop').css({
			top:-300,
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
	  

    })
    
	// ------------------------- TOUCH-MOVE / MOUSE-MOVE ------------------

    $('.pages').bind('touchmove.pageswipe mousemove.pageswipe', function(event) {
	event.preventDefault() 
	  
     if (!touchDown) {
        return true;
      }
	  
	  if(o.swipable==false){
		return false  
		 }
	  
	  clearSettings();
	  deInitSlide(currentPage,currentSubPage);
      
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
	  
	  numberOfSubPages = $('.subpage',$('.page')[currentPage]).length

		z = 0;
		z2= 0;
		z3= 0;
		z4= 0;

      if (scrollDirection == "h") {
		 
        if (e.preventDefault) {
          e.preventDefault() /* Disable other scroll directions when we are scrolling horizontally */
        }
		
		
        if(horizontalDirection == "right" && horizontalTouchStart < 20 && horizontalTouchDelta < 300 && horizontalTouchDelta > 0){
			z4 = 1;
			
			$('#subMenuLeft').css({
				left:-300+horizontalTouchDelta
			});
		}
		else if(horizontalDirection == "right" && horizontalTouchStart < 20 && horizontalTouchDelta > 300 ){
			
			z4 = 1;
			$('#subMenuLeft').css({
				left:0
			});
		}
		else if(horizontalDirection == "left" && horizontalTouchStart > breite-20 && horizontalTouchDelta > -300 && horizontalTouchDelta <0){
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
          (horizontalDirection == "right" && currentPage > 0 && allowedLeft == 1) || /* Make sure we cannot scroll to the left of the first page. */
          (horizontalDirection == "left" && currentPage < parseInt(numberOfPages)-1 && allowedRight == 1 && z3 == 0 && z4 == 0) /* Make sure we cannot scroll beyond the last page. */
        ) {
			
			
		// if on subpage, clone the page and set it to the top, for smooth (but unlogic) sliding
		  //alert(parseInt($('#debugSubPage').html()));
		  v = parseInt($('#debugSubPage').html());
		  if(v > 0 && $('.clone').length==0){	
		  	if(v>1){
				x=v-1;}  
			else{
				x=0;}
			$('.subpage:eq('+x+')',$('.page')[currentPage]).clone().addClass('clone').css('z-index','9999').prependTo($('.page')[currentPage]);
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
		
		if(verticalDirection == "up" && verticalTouchStart > hoehe-20 && verticalTouchDelta > -300 && verticalTouchDelta < 0){
			z = 1;
			$('#subMenu').css({
				bottom:-300-verticalTouchDelta
			});
		}
		else if(verticalDirection == "up" && verticalTouchStart > hoehe-70 && verticalTouchDelta < -300 ){
			
			z = 1;
			$('#subMenu').css({
				bottom:0
			});
		}
		else if(verticalDirection == "down" && verticalTouchStart < 70 && verticalTouchDelta > -300 && verticalTouchDelta < 300){
			
			z2 = 1;
			$('#subMenuTop').css({
				top:-300+verticalTouchDelta
			});
			$('#subMenu').css({
				bottom:-300+verticalTouchDelta
			});
			
			x = verticalTouchDelta / 300
			
			$('.pages').css({
				opacity: 1
			})
			
		}
		else if(verticalDirection == "down" && verticalTouchStart < 70 && verticalTouchDelta > -300 && verticalTouchDelta >= 300){
			z2 = 1;
			$('#subMenuTop').css({
				top:0
			});
			$('#subMenu').css({
				bottom:0
			});
			$('.pages').css({
				opacity: 1
			})
		}
        else if ( 
          ((verticalDirection == "down" && currentSubPage > 0 && allowedTop==1) || /* Make sure we cannot scroll to the left of the first page. */
          (verticalDirection == "up" && currentSubPage < numberOfSubPages && allowedBottom==1 && numberOfSubPages > 0) && z == 0 && z2 == 0) /* Make sure we cannot scroll beyond the last page. */
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
	$('.pages').bind('touchend.pageswipe mouseup.pageswipe', function(event) {
	
		touchDown = false
		e = event.originalEvent
		
		if (e.type == 'mouseup') {
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
		
			if (horizontalTouchDelta < 80 && horizontalTouchDelta > -80 && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
				goIntoCSSTransform = 0
				nextPositionH = (-deviceWidth * (currentPage))	
				nextPositionV = (-deviceHeight * (currentSubPage))	
				
				//alert(currentPage);
				
				that[0].style.WebkitTransform = "translate3d("  + nextPositionH + "px,"+nextPositionV+"px,0)"
				
				that[0].style.msTransition = 'all 0.3s linear'
				that[0].style.msTransform = "translate(" + nextPositionH + "px, "+nextPositionV+"px)"
				
				that[0].style.MozTransition = 'all 0.3s linear'
				that[0].style.MozTransform = "translateX("  + nextPositionH + "px)"
				
				that[0].style.OTransition = 'all 0.3s linear'
				that[0].style.OTransform = "translateX(" + nextPositionH + "px)"
				
			} 
			else if (horizontalTouchDelta > 80 && allowedRight == 1 && currentPage < numberOfPages-1 && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
			
				nextPositionH = (-deviceWidth * (currentPage+1))
				nextPositionV = 0
				
				that[0].style.WebkitTransform = "translate3d("  + nextPositionH + "px,0,0)"
				
				that[0].style.msTransition = 'all 0.3s linear'
				that[0].style.msTransform = "translate(" + nextPositionH + "px, 0)"
				
				that[0].style.MozTransition = 'all 0.3s linear'
				that[0].style.MozTransform = "translateX("  + nextPositionH + "px)"
				
				that[0].style.OTransition = 'all 0.3s linear'
				that[0].style.OTransform = "translateX(" + nextPositionH + "px)"
				
				if (jQuery.browser.version == "8.0") {
				that[0].style.left = nextPositionH
				that[0].style.top = nextPositionV
				}
				currentPage++
				currentSubPage = 0;
			
			} else if (horizontalTouchDelta < 80 && allowedLeft == 1 && currentPage > 0 && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
				
				currentPage--
				nextPositionH = (-deviceWidth * (currentPage))
				nextPositionV = 0
				
				that[0].style.WebkitTransform = "translate3d("  + nextPositionH + "px,0,0)"
				
				that[0].style.msTransition = 'all 0.3s linear'
				that[0].style.msTransform = "translate(" + nextPositionH + "px, 0)"
				
				that[0].style.MozTransition = 'all 0.3s linear'
				that[0].style.MozTransform = "translateX("  + nextPositionH + "px)"
				
				that[0].style.OTransition = 'all 0.3s linear'
				that[0].style.OTransform = "translateX(" + nextPositionH + "px)"
				
				if (jQuery.browser.version == "8.0") {
				that[0].style.left = nextPositionH
				that[0].style.top = nextPositionV
				}
				currentSubPage = 0;
				
				
			} 
			else{
				goIntoCSSTransform = 0	
			}
			if($('.clone').length){
			  $('.clone').remove();	 
			}
		
			// direction indicator
			// all 4 directions
			
			/*if(currentPage>0 && currentPage<numberOfPages-1){
				dirRight = 1
				dirLeft = 1
			}
			if(currentPage==0){
				dirRight = 1	
				dirLeft = 0
			}
			if(currentPage==numberOfPages-1){
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
			
			//depending on allowed directions
			if(allowedLeft==0){
				dirRight = 0
			}
			if(allowedRight==0){
				dirLeft = 0
			}
			if(allowedTop==0){
				dirDown = 0
			}
			if(allowedBottom==0){
				dirUp = 0
			}
			
			if(goIntoCSSTransform == 1){
				setBaloon(dirRight,dirLeft,dirUp,dirDown);
			}	*/
			
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
				transFadeBg(currentPage+'-'+currentSubPage);
				initSlide(currentPage,currentSubPage);
				afterSlide();
			}
		}
		numberOfSubPages = $('.subpage',$('.page')[currentPage]).length
		//mrz 17/5/2013
		z = 0
		z2 = 0
		z3 = 0
		z4 = 0
		goIntoCSSTransform = 1
		if (scrollDirection == "v") {
			//UP - scroll down content area
			if(parseInt($('#subMenu').css('bottom')) > -300){
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
					bottom:-300
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
				$('#siteMapWrapperB').fadeIn()
				z2 = 1
				goIntoCSSTransform = 0
			} else{
				$('#subMenuTop').css({
					top:-300
				})
				$('#siteMapWrapperB').fadeOut()
				z2 = 0;
				goIntoCSSTransform = 1
			}
			
			if (verticalTouchDelta < 80 && verticalTouchDelta > -80 && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
			goIntoCSSTransform = 0
			nextPositionV = (-deviceHeight * (currentSubPage))
			 nextPositionH = (-deviceWidth * (currentPage))
			  //alert(currentPage);
			 
			  that[0].style.WebkitTransform = "translate3d("+nextPositionH+"px,"  + nextPositionV + "px,0)"
			  
			  that[0].style.msTransition = 'all 0.3s linear'
			  that[0].style.msTransform = "translate("+nextPositionH+"px," + nextPositionV + "px)"
			  
			  that[0].style.MozTransition = 'all 0.3s linear'
			  that[0].style.MozTransform = "translateY("  + nextPositionV + "px)"
			  
			  that[0].style.OTransition = 'all 0.3s linear'
			  that[0].style.OTransform = "translateY(" + nextPositionV + "px)"
			  
			} else if (verticalTouchDelta > 80 && currentSubPage < numberOfSubPages && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
			 
			  nextPositionV = (-deviceHeight * (currentSubPage+1))
			  nextPositionH = (-deviceWidth * (currentPage))
			  
			 
			  that[0].style.WebkitTransform = "translate3d(" + nextPositionH + "px," + nextPositionV + "px,0)"
			  
			  that[0].style.msTransition = 'all 0.3s linear'
			  that[0].style.msTransform = "translate(" + nextPositionH + "px," + nextPositionV + "px)"
			  
			  that[0].style.MozTransition = 'all 0.3s linear'
			  that[0].style.MozTransform = "translate("+ nextPositionH + "px,"  + nextPositionV + "px)"
			  
			  that[0].style.OTransition = 'all 0.3s linear'
			  that[0].style.OTransform = "translate("+ nextPositionH + "px," + nextPositionV + "px)"
			  
			  if (jQuery.browser.version == "8.0") {
				that[0].style.top = nextPositionV
				that[0].style.left = nextPositionH
			  }
			  currentSubPage++
			  //DOWN
			} else if (verticalTouchDelta < 80 && currentSubPage > 0 && z == 0 && z2 == 0 && z3 == 0 && z4 == 0 && goIntoCSSTransform == 1) {
			
			  currentSubPage--
			  nextPositionV = (-deviceHeight * (currentSubPage))
			  nextPositionH = (-deviceWidth * (currentPage))
			  
			 
			  that[0].style.WebkitTransform = "translate3d("  + nextPositionH + "px," + nextPositionV + "px,0)"
			  
			  that[0].style.msTransition = 'all 0.3s linear'
			  that[0].style.msTransform = "translate(" + nextPositionH + "px," + nextPositionV + "px)"
			  
			  that[0].style.MozTransition = 'all 0.3s linear'
			  that[0].style.MozTransform = "translate("  + nextPositionH + "px,"+nextPositionV + "px)"
			  
			  that[0].style.OTransition = 'all 0.3s linear'
			  that[0].style.OTransform = "translate("+ nextPositionH + "px," + nextPositionV + "px)"
			  
			  if (jQuery.browser.version == "8.0") {
				 that[0].style.top = nextPositionV
				 that[0].style.left = nextPositionH
			  } 
			}
			else{
				goIntoCSSTransform = 0
			}
			// direction indicator
			// all 4 directions
			if(currentPage>0 && currentPage<numberOfPages-1){
				dirRight = 1
				dirLeft = 1
			}
			if(currentPage==0){
				dirRight = 1	
				dirLeft = 0
			}
			if(currentPage==numberOfPages-1){
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
				setBaloon(dirRight,dirLeft,dirUp,dirDown);
				$('li','#sitemap').css('color','white');
				$('#smChapSubPage'+currentSubPage,'#smChap'+currentPage).css('color','red');	
				$('#sitemap').css({'display':'block','zIndex':9999}).center().delay(1000).fadeOut(100);			
				transFadeBg(currentPage+'-'+currentSubPage);
				initSlide(currentPage,currentSubPage);
				afterSlide();
			}
		}
		
    });
 	
	init = function(){
		if(o.customDirections==false){
			$.get('/felix/music-app/ajax/slidableSitemap.html',function(data){
				$('#subMenu').append(data);
				var myScrollSitemap;
				var myScrollSitemap0;
				var myScrollSitemap1;
				var myScrollSitemap2;
				var myScrollSitemap3;
				swipableSitemapLoaded()
			});
			
			$.get('/felix/music-app/ajax/slidableSitemapVertical.html',function(data){
				$('#subMenuRight').append(data);
				$('#siteMapWrapperA').height($(window.availHeight-50))
				var myScrollSitemapA;
				var myScrollSitemap0A;
				var myScrollSitemap1A;
				var myScrollSitemap2A;
				var myScrollSitemap3A;
				swipableSitemapLoadedA()
			});
		}
		
		$.get('/felix/music-app/ajax/slidableKiosk.html',function(data){
			$('#subMenuTop').html(data);
			var myScrollSitemapB;
			swipableSitemapLoadedB()
		});
		
		$('#slogan').click(function(){
			showSettings();
		});

		// auto Jump
		if(o.jumpTo != null && o.jumpTo != 'undefined' && o.jumpTo != '1-0'){
			scrollToPage(o.jumpTo.split('-')[0],o.jumpTo.split('-')[1],'0','slide');	
		}
		$(window).on("keyup.pageswipe", function(e) {	
			if(o.keys==false){
				return false	
			}	
			horizontalTouchEnd = e.pageX
			verticalTouchEnd = e.pageY	
			dirEvent = 1	
			var numberOfSubPages = numberOfSubPages = $('.subpage',$('.page')[currentPage]).length	
			var code = e.which;	
			if (code == 37 && currentPage > 0) {
				scrollToPage(parseInt(currentPage)-1,0,0.3,'slide');	
			}
			else if (code == 39 && currentPage+1 < numberOfPages) {
				// vorwärts		
				scrollToPage(parseInt(currentPage)+1,0,0.3,'slide');	
			}
			else if (code == 40 && currentSubPage < numberOfSubPages) {
				scrollToPage(currentPage,parseInt(currentSubPage)+1,0.3,'slide');		
			}
			else if (code == 38 && currentSubPage > 0) {
				scrollToPage(currentPage,parseInt(currentSubPage)-1,0.3,'slide');				
			}
			else if (code == 32 ) {
				dirEvent = 0
				showSlideInPanel('left');	
			}
			else if (code == 27 ) {
				//scrollToPage(0,0,0.3,'slide');	
				doOnOrientationChange();
			}
			else if (code == 13 ) {
				if (fullScreenApi.supportsFullScreen) {
					fullScreenApi.requestFullScreen(document.getElementById('bdy'));	
					$('.viewport').css('height',screen.height);
					$('.viewport').css('width',screen.width);
					$('.page,section,.subpage').css('height',screen.height);
					$('.page,section,.subpage').css('width',screen.width);
					scrollToPage(0,0,0.3,'slide');
				}
			}
			if(dirEvent==1){
				$('li','#sitemap').css('color','white');
				$('#smChapSubPage'+currentSubPage,'#smChap'+currentPage).css('color','red');	
				$('#sitemap').css({'display':'block','zIndex':9999}).center().delay(1250).fadeOut(100);			
			}
		});
		$(window).bind('orientationchange', doOnOrientationChange);
		preloadAllBgImages()
		$('#loading').delay(2000).fadeOut()
		if(o.customDirections==true){
			//$('#chapterNav').hide();
		}
		else{
			$('#chapterNav').show();	
		}
		
		/*if (("standalone" in window.navigator) && !window.navigator.standalone && os == 'ios'){
			$('#webAppInfo').center();
			$('#webAppInfo').fadeIn().delay(4000).fadeOut(200,function(){$('#webAppInfo').remove();});
		}
		if (os!='ios'){
			$('#webAppInfo2').center();
			$('#webAppInfo2').fadeIn().delay(4000).fadeOut(200,function(){$('#webAppInfo2').remove();});
		}*/
		
		$('.layoutElem').each(function(){
			if($(this).hasOverflow()){
				$(this).addClass('overflowed');
			}
		});
		
		
		
		$('.overflowed').unbind('touchstart,touchmove,tochend');
		$('.overflowed').bind('touchmove', function(e){
			e.stopImmediatePropagation()
		});
		
		/*var rtime = new Date(1, 1, 2000, 12,00,00);
		var timeout = false;
		var delta = 200;
		var v;*/
		
		/*$(window).resize(function(){
			
			rtime = new Date();
			if (timeout === false) {
				timeout = true;
				v = setTimeout(doOn OrientationChange, delta);
			}
		})*/
	}
	
	
	init();
    return this 
  };
})( jQuery )
