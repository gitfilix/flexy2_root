<cfprocessingdirective pageencoding="utf-8" />

<!--- 
	first check if mandant has more than 1 publication
	if yes, then show a publication overview 
--->

<cfset pubCount = fs.getNumberOfPublications() />

<cfif session.pubID NEQ 0>
	<cfset pub = fs.getPublication(pubID = session.pubID) />
</cfif>

<cfif session.issueID NEQ 0>
	<cfset matrix = fs.getMatrix(issueID = session.issueID) />
</cfif>


<!DOCTYPE HTML>
<!--[if IE 6]>
<html id="ie6" lang="de-CH" class="ie ie6 lt-ie9">
<![endif]-->
<!--[if IE 7]>
<html id="ie7" lang="de-CH" class="ie ie7 lt-ie9">
<![endif]-->
<!--[if IE 8]>
<html id="ie8" lang="de-CH" class="ie ie8 lt-ie9">
<![endif]-->
<!--[if gte IE 9]>
<html lang="de-CH" class="ie ie9">
<![endif]-->
<!--[if !(IE)]><!-->
<html lang="de-CH" class="">
<!--<![endif]-->
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1.0;">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="author" content="marcolago">

	<meta name="description" content="">

	<title></title>
	
	<!--- <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,800,700italic,700&subset=latin,latin-ext' rel='stylesheet' type='text/css'> --->
	<link rel="stylesheet" href="css/reset.css">
	<!--- <link rel="stylesheet" href="css/flowtime.css"> --->
	<link rel="stylesheet" href="css/customstyles.css">
	<link rel="stylesheet" href="css/fullscreen.css">
	<link rel="stylesheet" href="css/animations.css">
	<link rel="stylesheet" href="css/fries.css">
	<link rel="stylesheet" href="inc/flexslider/flexslider.css">
	<link rel="stylesheet" href="js/3.0.5/photoswipe.css">
	
	<link rel="stylesheet" href="js/reveal.js-master/css/reveal.css"> 
	<!--- <link rel="stylesheet" href="js/reveal.js-master/css/theme/default.css" id="theme"> --->
	<link rel="stylesheet" href="css/tpl-1.css">
	<link rel="stylesheet" href="css/tpl-2.css">
	<link rel="stylesheet" href="css/tpl-3.css">
	
	<link rel="stylesheet" type="text/css" media="screen and (orientation: portrait)" href="css/portrait.css" >
	<link rel="stylesheet" type="text/css" media="screen and (orientation: landscape)" href="css/landscape.css" >
	
	
	 
</head>
<body id="fs-container" <cfif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)>style="background:transparent url('img/bg.jpg') center center no-repeat;background-size: cover;"</cfif>>
	<cfif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)>
	<div id="fs-inner" style="height:100%;">
		<div class="reveal">
	<div class="slides"></cfif>
			<cfif pubCount EQ 0>
				No existing publication. 
			<cfelseif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)>
				<cfinclude template="inc/matrix-reveal.cfm" />
			<cfelse>
				<cfinclude template="inc/pubs.cfm" />
			</cfif>
		<cfif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)></div>
	</div></div></cfif>
	<cfif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)>
		<div id="navigBar">
			<header class="action-bar fixed-top">
			  <a href="javascript: void(0);" class="app-icon action">
				<i class="icon-fries"></i>
			  </a>
			  <h1 class="title"><a href="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>?pubID=0&issueID=0">Travel-App</a></h1>
			  <ul class="actions pull-right">
				<li><a href="javascript: void(0);" class="action" title="Search" onClick="showOverlay('overlay-top-1');"><i class="icon-search"></i></a></li>
				<li><a href="javascript: void(0);" class="action" title="Copy" onClick="showOverlay('overlay-top-2');"><i class="icon-map"></i></a></li>
				<li><a href="javascript: void(0);" class="action" title="Cut" onClick="showOverlay('overlay-bottom');detachKeyEvents();"><i class="icon-mail"></i></a></li>
				<li><a href="javascript: void(0);" class="action" title="Settings" onClick="showOverlay('overlay-top-4');"><i class="icon-settings"></i></a></li>
			  </ul>
			</header>
			<div style="padding:1em;">
				<ul>
					<li>
						<a href="javascript:void(0);" onClick="showOverlay('overlay-top-1');" title="">
							Menü 1
						</a>
					</li>
					<li>
						<a href="javascript:void(0);" onClick="showOverlay('overlay-top-2');" title="">
							Menü 2
						</a>
					</li>
					<li>
						<a href="javascript:void(0);" onClick="showOverlay('overlay-top-3');" title="">
							Menü 3
						</a>
					</li>
					<li>
						<a href="javascript:void(0);" onClick="showOverlay('overlay-top-4');" title="">
							Menü 4
						</a>
					</li>
					<li>
						<a href="javascript:void(0);" onClick="showInfoWindow('Hallo Welt');" title="">
							InfoWindow
						</a>
					</li>
					<li>
						<a href="javascript:void(0);" onClick="toggleLeftNav();" title="">
							Linke Navig
						</a>
					</li>
					<li>
						<a href="javascript:void(0);" onClick="showOverlay('overlay-bottom');" title="">
							Kontakt / Feedback
						</a>
					</li>
				</ul>
				<div style="clear:both;"></div>
			</div>
			<div style="text-align:center;">
				<a href="javascript:void(0);" id="menuhandle" style="background-color:#333;color:#fff;padding:0.5em;border-radius:10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
			</div>
		</div>
		
		<div id="offcanvas" style="z-index:1;position:absolute;left:-320px;top:0;background-color:#333333;height:100%;width:320px;">
			Hier kommt die Navig
		</div>
		
		<div id="overlay-infowindow" class="overlay infowindow" style="display:none;">
			Hier kommt eine Information
		</div>
		
		<div id="overlay-bottom" class="overlay" style="position:absolute;bottom:0;display:none;left:0;width:100%;height:320px;background-color:#333333;opacity:0.85;">
			<form class="inset">
			  <label class="block-label">Email</label>
			  <input type="email" name="email" placeholder="Email" class="input-text">
			  <label class="block-label">Password</label>
			  <input type="password" name="password" placeholder="Password" class="input-text">
			  <div class="form-actions">
				<input type="submit" class="btn btn-block" value="Submit">
				<button type="button" class="btn btn-block">Cancel</button>
			  </div>
			</form>
		</div>
		
		<div id="overlay-top" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:250px;background-color:#333333;">
			Hier kommt weiteres
		</div>
		
		<div id="overlay-top-1" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:100px;background-color:#333333;opacity:0.85;">
			Hier kommt weiteres
		</div>
		
		<div id="overlay-top-2" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:92%;background-color:#333333;opacity:0.85;text-align:center;">
			<br/>
			<img src="img/map.png" style="max-height:100%;width:100%;">
			<br/><br/>
		</div>
		
		<div id="overlay-top-3" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:250px;background-color:#333333;opacity:0.6;">
			Hier kommt weiteres
		</div>
		
		<div id="overlay-top-4" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:250px;background-color:#333333;opacity:0.85;">
			Hier kommt weiteres
		</div>
		
		<div id="lightbox">
			<div style="padding:3em;width:88%;height:100%;">
				
			</div>
			<span style="position:absolute;top:0.3em;right:0.5em;z-index:1001;padding:0.2em;font-size:4em;">
				<a href="javascript:void(0);" onClick="closeLightbox();">X</a>
			</span>
		</div>
		
		<div id="rotate" style="height:100%;width:100%;display:none;">
			<div style="color:white;">Rotate your device</div>
		</div>
		
		<nav class="footer action-bar fixed-bottom">
			<div style="padding-top:15px;text-align:center;">
				by futureScreen &copy; 2013
			</div>
		</nav>
		
		<div class="loglog"></div>
	</cfif>
	
	<!--- load jQuery --->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<!--- only load and init scripts when a single publication is chosen --->
	<cfif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)>
		<script src="js/jquery.fittext.js"></script>
		<script src="js/fries.js"></script>
		<script src="inc/flexslider/jquery.flexslider.js"></script>
		<script src="js/iscroll5/dist/iscroll-min.js"></script>
		<script src="js/3.0.5/lib/klass.min.js"></script>
		<script src="js/3.0.5/code.photoswipe.jquery-3.0.5.min.js"></script>
		
		<script src="js/reveal.js-master/lib/js/head.min.js"></script>
		<script src="js/reveal.js-master/js/reveal.min.js"></script>
<script src="js/scripts-reveal.js"></script>
		<script>
			// Full list of configuration options available here:
			// https://github.com/hakimel/reveal.js#configuration
			Reveal.initialize({
				width: '100%',
			    height: '100%',
				controls: true,
				progress: true,
				history: true,
				mouseWheel: true,
				center: false,
				theme: Reveal.getQueryHash().theme, // available themes are in /css/theme
				transition: Reveal.getQueryHash().transition || 'none', // default/cube/page/concave/zoom/linear/fade/none
				backgroundTransition: 'fade',
				previewLinks: true,
				margin: 0,
				loop: true,
				// Parallax scrolling
				// parallaxBackgroundImage: 'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg',
				// parallaxBackgroundSize: '2100px 900px',
				// Optional libraries used to extend on reveal.js
				dependencies: [
					{ src: 'js/reveal.js-master/lib/js/classList.js', condition: function() { return !document.body.classList; } },
					{ src: 'js/reveal.js-master/plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
					{ src: 'js/reveal.js-master/plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
					{ src: 'js/reveal.js-master/plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
					{ src: 'js/reveal.js-master/plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } }
				]
			});
			
			Reveal.addEventListener( 'ready', function( event ) {
				initFlexSlider(2);
				initLightbox();
				initFlip();
				initFitText();
			} );
		</script>
		
		
	<cfelse>
		<script>
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
				$('#pubWrapper').vAlign();
				
				$('.issue').on('click',function(){
					// first hide all issue divs
					$('.issue').next().slideUp();
					// toggle clicked issue div only when not active
					if($(this).next().css('display')=='none'){
						$(this).next().slideToggle();
					}
				});
			});	
		</script>
	</cfif>
	
</body>
</html>
