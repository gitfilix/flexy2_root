function tpl7(){
	if(!navigator.onLine){
		$('.tpl7-ytHolder').hide();
		$('.tpl7-textContainer-yt').css({
			height:'100%'
		})
	}
	$('section[data-template=7]').each(function(){
		_this = $(this)
		// only init gallery if availible
		if($('.swipeGallery',_this).length>0){
			// loop through each gallery
			$('.swipeGallery',_this).each(function(idx){
				// init photoswipe
				$("a",'.swipeGallery').photoSwipe({
					captionAndToolbarHideOnSwipe: false,
					captionAndToolbarFlipPosition: true,
					captionAndToolbarShowEmptyCaptions: true
				})
				
			})
		}
	})	
}

function tpl7onSlide(slideObj){
	//initFTscroller();	
	
	
	
	
	
}
