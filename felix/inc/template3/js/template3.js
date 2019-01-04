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

$(document).ready(function(e) {
	// vertikal alignieren von querformat-bildern
	$(".thumbbox").vAlign();
	// hover-effekt mit lupe hilite
	$(".thumbnailGalleryElem").mouseenter(function(){
		$('.enlargeLupe',this).css('background-color','white');
		$('.enlargeLupe',this).css('padding','0.2em');	
	}).mouseleave(function(){
		$('.enlargeLupe',this).css('background','none');
		$(this).css('padding',0);	
	});
	
	$(".fullGalleryElem").mouseenter(function(){
		$('.enlargeLupe',this).css('background-color','white');
		$('.enlargeLupe',this).css('padding','0.2em');	
	}).mouseleave(function(){
		$('.enlargeLupe',this).css('background','none');
		$(this).css('padding',0);	
	});
});