
$(document).ready(function() {

// Flex-Slider  	
	if (jQuery().flexslider) {
	   $('.flexslider').flexslider({
			smoothHeight: true, 
			controlNav: false,           
			directionNav: true, 
			animation: "fade",
			slideshowSpeed: 5000, 
			animationSpeed: 1000, 
		   	reverse: true,
		    startAt: -1,
		    initDelay: 30,
		    easing: "swing",
			//prevText: "&larr;",
			//nextText: "&rarr;",
			selector: ".slides > .slide"
	    });
	}
    
    
    
// Smooth scrolling - css-tricks.com


});
				