
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


$(document).ready(function(){	
	dHeight = $('body').height();
	wHeight = $(window).height();
	
	if(dHeight<wHeight){
		hgt = $('#first').height();
		hgt2 = $('#lastRow').height();
		tot = parseInt(hgt)+parseInt(hgt2);
		newHeight = parseInt(wHeight)-parseInt(tot);
		$('#BlueBar').height(parseInt('hgt2'));	
	}
	
	$(".yoxview").yoxview({
		lang: "de",
		autoHideInfo: false,
		autoHideMenu: false
	});		
	
	$('#mobileNav>a').click(function(e){
		e.preventDefault();
		$('#mobileNav>ul').slideToggle();
	});
	// html5 validierung mit fallback auf javascript in non-html5 browsers
	$('.forms').html5form({
		allBrowsers: true,
		messages: 'de',
		responseDiv : '.response',
		async : false
	}); 
	
	
})	

function submitContactForm(){
	contact = '#kontaktformular';
	// append hidden captcha / human detection into DOM
	$hiddenInput = $('<input/>',{type:'hidden',id:'hiddenCheckbox',name:'iAmNotAbot',value:'itSeemsIamAhuman'});
	$hiddenInput.prependTo('.captcha',contact);
	//disable send-button to prevent multiple clicks
	$('#send').attr('disabled', 'disabled');
	$('#send').addClass('disabled');
	// from send
	$('#kontaktformular').fadeOut(1000,function(){
		// procedure:
		//ajax post: $post(url, formdata, callbackfunction); 
		// 3.paramenter: callback wenn erfolgreich -> data-variable ("danke für")
		// hier statischer pfad von sendcontact file
		$.post('/webdesign/inc/sendContact.cfm?formSubmited=true', $('#kontaktformular').serialize(),function(data){
			$('#kontaktformular').before('<span id="thx">'+data+'</span>');
			// is there a word "danke"?
			if(data.indexOf('Danke')>-1){
				$('#kontaktformular').remove();
			}
			else{
				$('#kontaktformular').fadeIn();
			}
			//setTimeout(function() {$('#thx').fadeOut().remove()}, 2000);
		});
	});	
}

function res(){
	if(screen.width<=450){
		$(".bluepanel").height('auto');
		$("#BlueBar").height('auto');
	}
	else{
	
		hgt = 0;
		$('.teaser-elem').each(function(){
			if($(this).height()>hgt){
				hgt = $(this).height();	
			}
		});
		$('.teaser-elem').height(hgt).css('margin-bottom',20);
		$('.sidebar_bottom').height(hgt).css('margin-bottom',20);	
		
		$(".bluepanel").height('auto');
		$("#BlueBar").height('auto');
		
		if($("#eqHeightRef").height() > $("#BlueBar").height()){	
			$("#BlueBar").height($("#eqHeightRef").height());
			//$(".bluepanel").height($("#BlueBar").height());
		}	
		
		
	}
	//	 $('html, body').animate({scrollTop:0}, 'slow');
}

$(window).load(function() {
	res();
	
	$('.flexslider').flexslider({
		smoothHeight: true, 
		controlNav: false,         
		directionNav: false,  
		selector: ".slides > .slide",
		animation:'fade'
	});
	
});
	 
if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
	var viewportmeta = document.querySelector('meta[name="viewport"]');
	if (viewportmeta) {
		viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0';
		document.body.addEventListener('gesturestart', function() {
			viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6';
		}, false);	
	}
}


$(window).resize(function() {
	setTimeout("res()",100);
});

$(window).bind("orientationchange",function(e) {
	setTimeout("res()",100);
});