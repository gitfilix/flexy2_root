
(function ($) {
// VERTICALLY ALIGN FUNCTION
$.fn.vAlign = function() {
  return this.each(function(i){
  var ah = $(this).height();
  var ph = $(this).parent().parent().height();
  var mh = (ph - ah) / 2;
  if(mh>0) {
    $(this).css('margin-top', mh);
  } else {
    $(this).css('margin-top', 0);
  }
});
};
})(jQuery);


$(document).ready(function() {


// FLX -seichmachi function -just for Tschagga!


//$('.team-hover').on('mouseOver',function(){
//	$('img',this).attr('src',$('img',this).attr('src').replace('.png','_r.png'))
//	})

//$('.yoxview').yoxview();


// Slider  	
//	if (jQuery().flexslider) {
//	   $('.flexslider').flexslider({
//			smoothHeight: true, 
//			controlNav: true,           
//			directionNav: true,  
//			prevText: "&larr;",
//			nextText: "&rarr;",
//			selector: ".slides > .slide"
//	    });
//	};
    
    
    
// Smooth scrolling - css-tricks.com


});
				
$(window).load(function(){
	$('.team-hover').on('mouseover',function(){
		$('img',this).attr('src',$('img',this).attr('src').replace('.png','_r.png')).css({'transform': 'scale(1.2, 1.2)',  'transition':'all  0.2s ease-in'})
	}).on('mouseout',function(){
		$('img',this).attr('src',$('img',this).attr('src').replace('_b_r.png','_b.png')).css({'transform': 'scale(0.9, 0.9)', 'transition':'all  0.2s ease-out' })
	});
	

// FLX -seichmachi function -just for Tschagga!	
	$('#aniMe').delay(2000).animate({
		'padding-left' : '16em',
		'opacity': '0.1',
		'height' :'0px'
			},450);
		
})