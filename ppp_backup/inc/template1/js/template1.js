
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

$(window).load(function(){
	if (jQuery().validate) {
	    	$("#contact_form").validate();	 
	};
	});


/*
$(window).load(function(){
hgt = 10	
	$('teaserdown').each(function(){
		if($(this).height()>hgt){
			} hgt = $(this).height();
		});
	$('teaserdown').height(hgt); 
});


(function(){
	hgt = 0;	
		$('.teaserdown').each(function(){
			if($(this).height()>hgt){
				} hgt = $(this).height();
			});
			console.log(hgt);
		$('.teaserdown').height(hgt); 
		$('.teaserdown').css('padding-bottom','90px'); 
	
	})();
*/