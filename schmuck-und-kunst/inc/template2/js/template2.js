/* FLX define & customize here some  Flex-slider functions  */
$(window).load(function() {
    $('.flexslider').flexslider({
		//directionNav: false,
		slideshow: true, 
		pauseOnHover: true,
		randomize: false,
		animationSpeed: 1500,   
		slideshowSpeed: 7500,
		startAt:0,
	    initDelay: 10000
	});
	// equal heigt of teasers
	hgt = 0;
	$('.SidebarElems').each(function(){
		if($(this).height()>hgt){
			hgt = $(this).height();	
		}
	});
	$('.SidebarElems').height(hgt);
  });
 
// contactform validation
	if (jQuery().validate) {
	    	$("#contact_form").validate();	 
	};
	
	hgt = 0;
		$('.SidebarElems').each(function(){
			if($(this).height()>hgt){
				hgt = $(this).height();	
			}
		});
	$('.SidebarElems').height(hgt).css('padding-bottom','1em');
	$('.SidebarElems').height(hgt);	  
	
//  contactform capcha and submit fadeout
	