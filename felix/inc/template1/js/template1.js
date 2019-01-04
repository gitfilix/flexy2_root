

/* FLX define & customize here some slider functions  */
$(window).load(function() {
    $('.flexslider').flexslider({
		directionNav: false,
		randomize: false
	});
  });
  
  

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