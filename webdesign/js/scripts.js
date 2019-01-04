$(document).ready(function() {

// BX FLX slider
  $('.bxslider').bxSlider();
  
// FLX cool navig from left activation on trigger on button img.
$('#menu-btn').click(function() {
		//$('#app').toggleClass('nav-open');
		//$('#left-navig').toggleClass('nav-open');
		// works also
		if($('#app').hasClass('nav-closed')){
			$('#app,#left-navig').removeClass('nav-closed');
			$('#app,#left-navig').addClass('nav-open');
			// then fade in the logo once
			$('#company').animate({
				'opacity':'1'
				},2400);
		}
		else{
			$('#app,#left-navig').removeClass('nav-open');
			$('#app,#left-navig').addClass('nav-closed');			
		}
		
		
		
		
	});
	$('#logo').click(function() {
		//$('#app').toggleClass('nav-open');
		//$('#left-navig').toggleClass('nav-open');
		// works also
		if($('#logo').hasClass('nav-closed')){
			$('#logo').removeClass('nav-closed');
			$('#logo').addClass('nav-open');
		}
		else{
			$('#logo').removeClass('nav-open');
			$('#logo').addClass('nav-closed');			
		}
	});
	

	// big picture
	//$('.bigimg').animate({
		//'opacity': '1'
		//},1000);
		
		
	
	// logo
	//$('#company').fadeIn(10, function(){
	//	$('h1').fadeIn(2600);
//	});

	
// the Big Picture show off
	$('.bigimg').animate({
		'opacity':'1'
		},2200,'linear', function(){
				$('#imagetitle').animate({
				'color':'#5df2ff'
				},800, function(){
					$('#imagedesc').animate({
					'color':'#e3e3e3'
					},600,'easeInExpo');
			});
	});
	
	
	
	// content below fade in
	$('.text-content').delay(1800).animate({
		'color':' #333333',
		'padding-left': '4em'
		},1000, 'easeOutExpo', function(){
		$('.text-content h2').animate({
				'color':'#666666',
				'border-top-color':'#111'	
				},1600, function(){
					$('.text-content a').animate({
						'color':'#333333'
						},400)
					});
		});
	
	
	// sidebar fade in at least
	$('.sidebar img').delay(2700).animate({
		'opacity':'1'
		},600, function(){
			$('.sidebar h4').animate({
				'color':'#999999'
				},600,function(){ 
					$('.sidebartext').animate({
					'color':'#FAFAFA',	
					'padding-left':'1em'
						},800,'easeInExpo', function(){
						$('.sidebar a').animate({
						'border-bottom-color': '#F6F6F6'
						},1200)
				});
			});
		});
		
	//$('#headings').animate({
	//	'right': '40px'	
	//},300);
	



	// the nav swipe
	$('#menu-btn').animate({
		//'left':'30px'
		//},1200,'easeInExpo'
	});
	
	
	// nav button glow effect by flx
	var speed= 1000;
	var times= 5;
	var loop = setInterval(anim, 1000);
	function anim(){
		times--;
		if(times === 0){clearInterval(loop);}
		$('#menu-btn').animate({
			'border-color':'#FAFAFA'
			},speed).animate({
				'border-color':'#888'
				},speed)
		}
	anim();
	

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



