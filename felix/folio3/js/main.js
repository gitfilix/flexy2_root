jQuery.fn.center = function () {
	this.css("position","absolute");
	this.css("top", (($(window).height() - this.outerHeight()) / 2) + $(window).scrollTop() + "px");
	this.css("left", (($(window).width() - this.outerWidth()) / 2) + $(window).scrollLeft() + "px");
	return this;
};

$.fn.hasOverflow = function() {
	var $this = $(this);
	var $children = $this.find('*');
	var len = $children.length;

	if (len) {
		var maxWidth = 0;
		var maxHeight = 0
		$children.map(function(){
			maxWidth = Math.max(maxWidth, $(this).outerWidth(true));
			maxHeight = Math.max(maxHeight, $(this).outerHeight(true));
		});

		return maxWidth > $this.width() || maxHeight > $this.height();
	}

	return false;
};

(function( $ ){
	$.standardiseCfQueryJSON=function( cfQueryJSON )
	{
		var result  =   [];
		$.each( cfQueryJSON.DATA,function( rowNum,rowValue ){
			var row =   new Object();
			$.each( cfQueryJSON.COLUMNS,function( position,columnName ){
				row[ columnName.toLowerCase() ] = rowValue[ position ];
			});
			result.push( row );
		});
		return result;
	};
})( jQuery );


/* 
Native FullScreen JavaScript API
-------------
Assumes Mozilla naming conventions instead of W3C for now
*/

(function() {
	var 
		fullScreenApi = { 
			supportsFullScreen: false,
			isFullScreen: function() { return false; }, 
			requestFullScreen: function() {}, 
			cancelFullScreen: function() {},
			fullScreenEventName: '',
			prefix: ''
		},
		browserPrefixes = 'webkit moz o ms khtml'.split(' ');
	
	// check for native support
	if (typeof document.cancelFullScreen != 'undefined') {
		fullScreenApi.supportsFullScreen = true;
	} else {	 
		// check for fullscreen support by vendor prefix
		for (var i = 0, il = browserPrefixes.length; i < il; i++ ) {
			fullScreenApi.prefix = browserPrefixes[i];
			
			if (typeof document[fullScreenApi.prefix + 'CancelFullScreen' ] != 'undefined' ) {
				fullScreenApi.supportsFullScreen = true;
				
				break;
			}
		}
	}
	
	// update methods to do something useful
	if (fullScreenApi.supportsFullScreen) {
		fullScreenApi.fullScreenEventName = fullScreenApi.prefix + 'fullscreenchange';
		
		fullScreenApi.isFullScreen = function() {
			switch (this.prefix) {	
				case '':
					return document.fullScreen;
				case 'webkit':
					return document.webkitIsFullScreen;
				default:
					return document[this.prefix + 'FullScreen'];
			}
		}
		fullScreenApi.requestFullScreen = function(el) {
			return (this.prefix === '') ? el.requestFullScreen() : el[this.prefix + 'RequestFullScreen']();
		}
		fullScreenApi.cancelFullScreen = function(el) {
			return (this.prefix === '') ? document.cancelFullScreen() : document[this.prefix + 'CancelFullScreen']();
		}		
	}

	// jQuery plugin
	if (typeof jQuery != 'undefined') {
		jQuery.fn.requestFullScreen = function() {
	
			return this.each(function() {
				var el = jQuery(this);
				if (fullScreenApi.supportsFullScreen) {
					fullScreenApi.requestFullScreen(el);
				}
			});
		};
	}

	// export api
	window.fullScreenApi = fullScreenApi;	
})();

//var appCache = window.applicationCache;

/*function onDeviceReady() {
	navigator.network.isReachable("www.flx-media.ch", reachableCallback, {});
	localStorageContent = localStorage.getItem(localStorage.html);
	$('body').append(localStorageContent);
	window.setTimeout('initPageSwipe()',1000);	
}

function reachableCallback(reachability) {
	var networkState = reachability.code || reachability;

	var states = {};
	states[NetworkStatus.NOT_REACHABLE]                      = 'No network connection';
	states[NetworkStatus.REACHABLE_VIA_CARRIER_DATA_NETWORK] = 'Carrier data connection';
	states[NetworkStatus.REACHABLE_VIA_WIFI_NETWORK]         = 'WiFi connection';
	
	if(states[networkState]!='No network connection'){
		sessionStorage.setItem("network", "true");
	}
	else{
		sessionStorage.setItem("network", "false");
	}
	
	console.log(sessionStorage.getItem("network"));
}

function handleCacheEvent(e) {
  
}

function handleCacheError(e) {
  //alert('Error: Cache failed to update!');
};*/

function jumpToPage(x,y,z){
	$('.pages').pageSwipe({
		jumpTo: x+','+y+','+z,
		jumpToType: 'fade'
	});	
}

function initPageSwipe(device,orientation,page,swipableState,keyNav,transfade,customDirections){
	
	//$('#magBar').fadeIn(1000);
	$('.pages').css('display','block');
	$('.pages').pageSwipe({
		initOri: orientation,
		initDevice: device,
		jumpTo: page,
		swipable: swipableState,
		keys: keyNav,
		transfade: transfade,
		customDirections: customDirections
	});	
	
	x = $('<div style="display:none;background-color:white;padding:2em;color:black;font-size:30px;">Welcome to my mag.<br/>Please enjoy!</div>');
	$('.pages').css('opacity','1');
	/*$('body').append(x);
	x.center().fadeIn(500).delay(2000).fadeOut(function(){
		$('.pages').css('opacity','1');
	});*/
	$('.layoutElem').each(function(){
		if($(this).hasOverflow()){
			$(this).addClass('overflowed');
		}
	});
	
	
	
	$('.overflowed').unbind('touchstart,touchmove,tochend');
	$('.overflowed').bind('touchmove', function(e){
		e.stopImmediatePropagation()
	});
}

function loadMag(page){
	
	
	
		// detect device resolution and pass it to ajax-call
		var dev  = ''
		var ori = 1
		var ori2 = 'portrait'
		//alert($(window).width() + ' ' + $(window).height())
		if($(window).width()>$(window).height()){
			ori = 0
			ori2 = 'landscape'	
		}
		
		var os = "notIOS";
		
		if(navigator.userAgent.match(/(iPhone|iPod|iPad)/i)){
			os = "ios"
		}
		
		$('#magBar,#slogan').remove();
		spalshImg = $('<img src="/felix/folio2/img/splash_screen.jpg" style="height:100%;" />');
		$('#loading').css('background-color','#222').html(spalshImg).show()
		$.get('ajax/magbar.html?token='+new Date().getTime(),'',function(data1){	
			$('body').addClass(dev);
			$('body').addClass(ori2);
			$.get('ajax/mag.html?token='+new Date().getTime(),{device: dev, orientation: ori2, ori: ori},function(data2){
				
				$('header').html(data1);
				$('.pages').prepend(data2);
			
				if($('body').hasClass('portrait') && Modernizr.touch == false){
						
				}
				
				$.get('ajax/sitemap.html?token='+new Date().getTime(),{},function(data3){
					$('#sitemap').html(data3);	
				});
				
				$.get('ajax/chapterNav.html?token='+new Date().getTime(),{},function(data4){
					
					//$('#chapterNav').hide();
					initPageSwipe(dev,ori,page,true,true,true,false)
					$('#chapterNav').html(data4);	
				});
				
				$('.hover').not('.article').click(function(){
					if($(this).hasClass('flip')){
						$(this).removeClass('flip');	
					}
					else{
						$(this).addClass('flip');
					}
				});
				
				swipableGalleryLoaded = function(){
					myScrollGallery = new iScroll('GalleryWrapper',{
						snap: false,
						desktopCompatibility: true,
						momentum: true,
						zoom: false,
						hScrollbar: true,
						wheelAction: 'true',
						vScrollbar: false,
						checkDOMChanges: false
					});
					
				}	
				
				$('.article').click(function(){
					 LBpath = $(this).data('lightboxpath')
					 $.fancybox({
						'centerOnScroll': true,
						'type':'ajax',
						'href':LBpath,
						'onComplete': function(){
							
							var myScrollGallery;
							swipableGalleryLoaded()
						}
					});
				});
				
				//var myPhotoSwipe = $(".gallery a").photoSwipe({ enableMouseWheel: false , enableKeyboard: false });
				

				//$('#gallerie').html('<div id="PhotoSwipeTarget"></div>')
				
				
				var myPhotoSwipe = $(".gallery a").photoSwipe({allowRotationOnUserZoom:true,captionAndToolbarFlipPosition:true,captionAndToolbarAutoHideDelay:0});
				var myPhotoSwipe3 = $("#housegallery a").photoSwipe({allowRotationOnUserZoom:true,captionAndToolbarFlipPosition:true,captionAndToolbarAutoHideDelay:0,zIndex:99999});	

				/*(function(window, Util, PhotoSwipe){
				
					Util.Events.domReady(function(e){
						
						var instance;
						
						instance = PhotoSwipe.attach(
							[
								{ url: '/felix/folio2/js/3.0.5/examples/images/full/001.jpg', caption: 'Image 001'},
								{ url: '/felix/folio2/js/3.0.5/examples/images/full/002.jpg', caption: 'Image 002'},
								{ url: '/felix/folio2/js/3.0.5/examples/images/full/003.jpg', caption: 'Image 003'},
								{ url: '/felix/folio2/js/3.0.5/examples/images/full/004.jpg', caption: 'Image 004'},
								{ url: '/felix/folio2/js/3.0.5/examples/images/full/005.jpg', caption: 'Image 005'}
							],
							{
								target: window.document.querySelectorAll('#PhotoSwipeTarget')[0],
								preventHide: true,
								getImageSource: function(obj){
									return obj.url;
								},
								getImageCaption: function(obj){
									return obj.caption;
								}
							}
						);
					
						instance.show(0);
					});
					
					
					}(window, window.Code.Util, window.Code.PhotoSwipe));*/
							
					$('#layer').css('top',-window.height)
			
				});
			});	
	
		
	/*}*/
	
}



function loadExternalHTMLCode(){
	$.ajax({
		url:'http://www.flx-media.ch/felix/inc/cfc/mag.cfc?method=getAllPages&callback=tabmag',
		dataType: 'jsonp',
		type:'get',
		crossDomain: true,
		async: false,
		jsonp: 'jsonp',
		jsonpCallback: "tabmag",
		cache:false,
		success: function(datax){
			localStorage.setItem('html',JSON.stringify(datax));
			//displayExternalHTMLCode(datax);
		}
	 });	
}

function displayExternalHTMLCode(datax){
	data2 = JSON.parse(datax);
	x = data2['DATA'][0][0];
	$('.pages').append(x);
	window.setTimeout('initPageSwipe()',1000);	 
}

// Check if a new cache is available on page load.
/*window.addEventListener('load', function(e) {

  window.applicationCache.addEventListener('updateready', function(e) {
    if (window.applicationCache.status == window.applicationCache.UPDATEREADY) {
      // Browser downloaded a new app cache.
      // Swap it in and reload the page to get the new hotness.
      window.applicationCache.swapCache();
      if (confirm('A new version of this site is available. Load it?')) {
        window.location.reload();
      }
    } else {
      // Manifest didn't changed. Nothing new to server.
    }
  }, false);

}, false);

// Fired after the first cache of the manifest.
appCache.addEventListener('cached', handleCacheEvent, false);

// Checking for an update. Always the first event fired in the sequence.
appCache.addEventListener('checking', handleCacheEvent, false);

// An update was found. The browser is fetching resources.
appCache.addEventListener('downloading', handleCacheEvent, false);

// The manifest returns 404 or 410, the download failed,
// or the manifest changed while the download was in progress.
appCache.addEventListener('error', handleCacheError, false);

// Fired after the first download of the manifest.
appCache.addEventListener('noupdate', handleCacheEvent, false);

// Fired if the manifest file returns a 404 or 410.
// This results in the application cache being deleted.
appCache.addEventListener('obsolete', handleCacheEvent, false);

// Fired for each resource listed in the manifest as it is being fetched.
appCache.addEventListener('progress', handleCacheEvent, false);

// Fired when the manifest resources have been newly redownloaded.
appCache.addEventListener('updateready', handleCacheEvent, false);

document.addEventListener("deviceready", onDeviceReady, false); */


$(document).ready(function() {
	loadMag();
	$('body,#slogan').on('touchmove',function(e){
		e.preventDefault();	
	});
});	

	
$(window).load(function(){
	$('.layoutElem').each(function(){
		if($(this).hasOverflow()){
			$(this).addClass('overflowed');
			$(this).css({webkitOverflowScrolling: 'touch', overflow: 'auto'});
		}
	});
	
	$('.overflowed').unbind('touchstart,touchmove,tochend');
	$('.overflowed').bind('touchmove', function(e){
		e.stopImmediatePropagation()
	});
	
	
});