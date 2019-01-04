

//$(document).ready(function(){
	// equal heigt of text-below
//	hgt = 0;
//	$('#text-20').each(function(){
//		if($(this).height()>hgt){
//			hgt = $(this).height();	
//		}
//	});
//	$('#text-80').height(hgt);
//  });
	


$(document).ready(function() {

// BX FLX slider
  $('.bxslider').bxSlider();
  
// FLX cool navig from left activation on trigger on button img.
$('#menu-btn').click(function() {
		$('#app').toggleClass('nav-open');
		// works also
		//$('.nav-open').removeClass()
		//$('.nav-close').addClass()
	});
	$('#logo').click(function() {
		$('#app').toggleClass('nav-open');
		// works also
		//$('.nav-open').removeClass()
		//$('.nav-close').addClass()
	});
	

	// big picture
	//$('.bigimg').animate({
		//'opacity': '1'
		//},1000);
		
		
	
	// logo
	//$('#company').fadeIn(10, function(){
	//	$('h1').fadeIn(2600);
//	});

	$('.bigimg').animate({
		'opacity':'1'
		},1600,'linear', function(){
		$('#imagetitle').animate({
			'color':'#5df2ff'
			},600, function(){
				$('#imagedesc').animate({
					'color': '#e3e3e3'
				},600);
			});
			
	});
	
	
	// content below fade in
	$('.text-content').delay(2000).animate({
		'color':' #444',
		'padding-left': '4em'
		},800, 'easeOutExpo', function(){
		$('.text-content h3').animate({
				'color':'#666',
				'border-top-color':'#111'	
				},1200, function(){
					$('.text-content a').animate({
						'color':'#444'
						},400)
					});
		});
	
	
	// sidebar fade in at least
	$('.sidebar').delay(2600).animate({
		'opacity':'1'
		},600, function(){
			$('.sidebar a').animate({
				'border-bottom-color': '#C9C9C9'
				},1200)
			});
		
	//$('#headings').animate({
	//	'right': '40px'	
	//},300);
	


// yoxview gallery
	





// Slider  	
//	if (jQuery().flexslider) {
	//   $('.flexslider').flexslider({
	//		smoothHeight: true, 
	//		controlNav: true,           
	//		directionNav: true,  
	//		prevText: "&larr;",
	//	nextText: "&rarr;",
	//		selector: ".slides > .slide"
	//  });
	//};
    
    
    
// Smooth scrolling - css-tricks.com

});



