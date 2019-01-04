
//(function ($) {
// VERTICALLY ALIGN FUNCTION
//$.fn.vAlign = function() {
//  return this.each(function(i){
//  var ah = $(this).height();
//  var ph = $(this).parent().parent().height();
//  var mh = (ph - ah) / 2;
//  if(mh>0) {
//    $(this).css('margin-top', mh);
//  } else {
//    $(this).css('margin-top', 0);
//  }
//});
//};
//})(jQuery);


// flx-blog acordeon function
(function($) {
    // all Pannels are closed
  var allPanels = $('.accordion > dd').hide();
    
  $('.accordion > dt > a').click(function() {
    allPanels.slideUp(400);
   // open only if the next panel is closed
	if($(this).parent().next().css('display')=='none'){
	
	$(this).parent().next().slideDown(
		600,function(){
			$('.content h2').animate({
				'color':'#602833',
				'border-top-color':'#111'
				},1200,function(){
					$('.pix-content img').animate({
						'opacity':'1'
						},500)
					});
		});
		
	}
	
    return false;
  });

})(jQuery);



$(document).ready(function() {

	$('.logo h1').animate({
			'color':'#888'
			},1000, 'easeInExpo', function(){
				$('.logo h2').animate({
				'color':'#444'
				},800, 'linear');
			});

$('.yoxview').yoxview();

});



// Slider  	
	//if (jQuery().flexslider) {
	 //  $('.flexslider').flexslider({
	//		smoothHeight: true, 
	//		controlNav: true,           
	//		directionNav: true,  
	//		prevText: "&larr;",
	//		nextText: "&rarr;",
	//		selector: ".slides > .slide"
	 //   });
	//};
    
    
// Smooth scrolling - css-tricks.com



				