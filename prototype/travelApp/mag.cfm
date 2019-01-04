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
<html lang="de-CH" class="" ><!--- manifest="cacheManifest.cfm" --->
<!--<![endif]-->
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1.0;maximum-scale=1.0;user-scalable=0;">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="author" content="grossniklaus">

	<meta name="description" content="">

	<title></title>
	
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,800,700italic,700&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="css/reset.css">
	<!--- <link rel="stylesheet" href="css/flowtime.css"> --->
	
	<!--- <link rel="stylesheet" href="css/fullscreen.css"> --->
	<link rel="stylesheet" href="css/animations.css">
	<link rel="stylesheet" href="css/fries.css">
	<!--- <link rel="stylesheet" href="inc/flexslider/flexslider.css"> --->
	<link rel="stylesheet" href="js/3.0.5/photoswipe.css">
	<link rel="stylesheet" href="js/reveal.js-master/css/reveal.css">
	<link rel="stylesheet" href="js/reveal.js-master/css/theme/default.css" id="theme">
	<!--- <link rel="stylesheet" href="js/Swiper-master/dist/idangerous.swiper.css"> --->
	<link rel="stylesheet" href="css/leagueGothic.css">
	<link rel="stylesheet" href="css/customstyles.css">
	<link rel="stylesheet" href="css/tpl1.css" />
	<link rel="stylesheet" href="css/tpl2.css" />
	<link rel="stylesheet" href="css/tpl3.css" />
	<link rel="stylesheet" href="css/tpl6.css" />
	<link rel="stylesheet" href="css/tpl7.css" />
	<link rel="stylesheet" href="css/tpl8.css" />
	<cfif isdefined("url.printpdf")> 
		<link rel="stylesheet" media="print" href="js/reveal.js-master/css/print/pdf.css" />
	<cfelse>
		<link rel="stylesheet" media="print" href="js/reveal.js-master/css/print/paper.css" />
	</cfif>
	<cfset parallax = fs.getIssue(issueID=session.issueID).parallaxImage />
	<cfif parallax NEQ "">
		<style type="text/css">
			.backgrounds{
				background:transparent url('img/<cfoutput>#parallax#</cfoutput>') center top no-repeat;
				-webkit-animation: animatedBackgroundx 60s linear infinite;
				-webkit-animation-direction:alternate;
				-moz-animation:animatedBackgroundx 60s linear infinite;
				-moz-animation-direction:alternate;
				animation: animatedBackgroundx 60s linear infinite;
				animation-direction:alternate;
			}
		</style>
	</cfif> 
</head>
<body>

<cfif isdefined("session.loggedIn") and session.loggedIn EQ 1>

	<cfif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)>
		<div class="reveal">
			<div class="slides"></cfif>
			<cfif pubCount EQ 0>
				No existing publication. 
			<cfelseif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)>
				<cfinclude template="inc/matrix-reveal.cfm" />
			<cfelse>
				<cfinclude template="inc/pubs.cfm" />
			</cfif>
			<cfif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)>
		</div>
	</div>
	</cfif>
	<cfif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)>
		<div id="navigBar">
			<header class="action-bar fixed-top">
			  <a href="javascript: void(0);" class="app-icon action">
				<i class="icon-fries"></i>
			  </a>
			  <h1 class="title"><a href="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>?pubID=0&issueID=0">Travel-App</a></h1>
			 <!---  <ul class="actions pull-right">
				<li><a href="javascript: void(0);" class="action" title="Search" onClick="showOverlay('overlay-top-1');"><i class="icon-search"></i></a></li>
				<li><a href="javascript: void(0);" class="action" title="Copy" onClick="showOverlay('overlay-top-2');"><i class="icon-map"></i></a></li>
				<li><a href="javascript: void(0);" class="action" title="Cut" onClick="showOverlay('overlay-bottom');"><i class="icon-mail"></i></a></li>
				<li><a href="javascript: void(0);" class="action" title="Settings" onClick="showOverlay('overlay-top-4');"><i class="icon-settings"></i></a></li>
			  </ul> --->
			</header>
			<div style="padding:1.2em;position:relative;z-index:201;padding-left:150px;">
				<ul>
					<li>
						<a href="javascript:void(0);" onClick="Reveal.slide( 0, 0, 0 );hideInfoWindow();$('.overlay').hide();closeLeftNav()" title="">
							Home
						</a>
					</li>
					<li>
						<a href="javascript:void(0);" onClick="toggleOverviewMode();" title="">
							Übersicht
						</a>
					</li>
					<li>
						<a href="javascript:void(0);" onClick="showOverlay('overlay-top-2');" title="">
							Menü 2
						</a>
					</li>
					<!--- <li>
						<a href="javascript:void(0);" onClick="showOverlay('overlay-top-3');" title="">
							Menü 3
						</a>
					</li>
					<li>
						<a href="javascript:void(0);" onClick="showOverlay('overlay-top-4');" title="">
							Menü 4
						</a>
					</li> --->
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
				<a href="javascript:void(0);" id="menuhandle" style="background-color:#333;color:#fff;padding:0.4em;border-radius:0.3em;">&nbsp;&nbsp;Menu&nbsp;&nbsp;&nbsp;</a>
			</div>
		</div> 
		
		<div id="loadingSplashScreen" style="background:#333 url('img/<cfif session.issueid EQ 13>zplus-loading<cfelse>bg</cfif>.jpg') center center no-repeat;background-size:cover;width:100%;height:100%;position:absolute;top:0;left:0;z-index:999999;display:block;">
			<div style="display:none;min-width:300px;max-width:450px;margin:0 auto;height:300px;background-color:#e5e5e5;color:#333;border-radius:1em;" id="loading">
				<div style="height:50%;text-align:center;padding-top:2em;font-size:1.5em;font-weight:bold;font-family:Tahoma, Geneva, sans-serif;" onclick="$('#loadingDetails').slideToggle();">
					Die Publikation wird gestartet...<div id="loadingText"></div>
				</div>
				<div style="height:50%;text-align:center;overflow:auto;font-size:0.8em;display:none;font-size:1em;" id="loadingDetails">
					Status: <span id="applicationStatus">Online</span> - <cfset writeOutput( timeFormat( now(), "h:mm:ss TT" ) ) /><br/>
					<a id="manualUpdate" href="javascript:void(0);">Auf neue Version prüfen</a><br/>
					Fortschritt: <span id="cacheProgress">nicht verfügbar</span><br/>
					<ul id="applicationEvents"></ul>
				</div>
			</div>	
		</div>

		<div id="pageMap">
			<div id="pm">
				&nbsp;
			</div>
			<!--- <div id="navi">
				<a id="dirUp" class="navigate-up navigator" style="top:10px;left:49%;">
					&nbsp;
				</a>
				<a id="dirDown" class="navigate-down navigator" style="bottom:10px;left:49%;">
					&nbsp;
				</a>
				<a id="dirRight" class="navigate-right navigator" style="top:80px;right:20px;">
					&nbsp;
				</a>
				<a id="dirLeft" class="navigate-left navigator" navigator style="top:80px;left:20px;">
					&nbsp;
				</a>
				<!--- <a id="dirPrev" class="navigate-next" style="position:absolute;bottom:10px;left:42%;z-index:10;background-color:white;color:#333;padding:1em;border:1px solid silver;border-radius:5px;">
					&larr;
				</a>
				<a id="dirNext" class="navigate-prev" style="position:absolute;bottom:10px;right:40%;z-index:10;background-color:white;color:#333;padding:1em;border:1px solid silver;border-radius:5px;">
					&rarr;
				</a> --->
			</div> --->
		</div>
		
		<div id="loadingWheel" style="z-index:99999;display:none;width:70px;position:absolute;top:48%;left:48%;border:1px solid #ccc;color:#333;background-color:#fff;padding:1em;border-radius:5px;text-align:center;">
			<img src="http://images.zumyn.com/loading.gif" />
		</div>

		<div id="offcanvas" style="z-index:199;position:absolute;left:-320px;top:0;background-color:#333333;height:100%;width:320px;">
			Hier kommt die Navig
		</div>
		
		<div id="overlay-infowindow" class="overlay infowindow" style="display:none;">
			Hier kommt eine Information
		</div>
		
		<div id="overlay-bottom" class="overlay" style="position:absolute;bottom:0;display:none;left:0;width:100%;height:320px;background-color:#333333;z-index:200;">
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
		
		<div id="overlay-top" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:250px;background-color:#333333;z-index:199;">
			Hier kommt weiteres
		</div>
		
		<div id="overlay-top-1" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:100px;background-color:#333333;z-index:199;">
			Hier kommt weiteres
		</div>
		
		<div id="overlay-top-2" class="overlay" style="position:absolute;top:0;display:none;left:0;width:100%;height:100%;background-color:#333333;text-align:center;z-index:199;">
			<br/>
			<img src="img/map.png" style="max-height:100%;width:100%;">
			<br/><br/>
		</div>
		
		<div id="overlay-top-3" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:250px;background-color:#333333;z-index:199;">
			Hier kommt weiteres
		</div>
		
		<div id="overlay-top-4" class="overlay" style="position:absolute;top:50px;display:none;left:0;width:100%;height:250px;background-color:#333333;z-index:199;">
			Hier kommt weiteres
		</div>
		
		<div id="lightbox">
			<div style="height:100%;"></div>
			<span style="display:block;position:absolute;top:0.3em;right:0.2em;z-index:1001;padding:0.2em;font-size:2.5em;">
				<button class="large" onClick="closeLightbox();" style="display:block;padding:1em;border-radius:1em;border:0;background-color:#333;color:#fff;cursor:pointer;">close</button>
			</span>
		</div>
		
		<div id="vidControl">
			<div style="text-align:center;">
				<div id="vidControl-btnPlay" class="vidControlBtn hidden"><input value="Pause" type="button" class="play" style="background:none;border:0;" /></div>
				<div id="vidControl-btnPause" class="vidControlBtn hidden"><input value="pause" type="button" class="pause " /></div>
				<div id="vidControl-btnMute" class="vidControlInfo hidden">Stumm <input class="muted" type="checkbox" /></div>
				<div id="vidControl-btnTime" class="vidControlSlider hidden">Fortschritt <input class="time-slider" type="range" disabled value="0" step="any" /></div>
				<div id="vidControl-btnVol" class="vidControlSlider hidden">Lautstärke <input class="volume-slider" type="range"  value="1" max="1" step="0.01" /></div>
				<div id="vidControl-btnVol" class="vidControlInfo"><span class="current-time"></span> / <span class="duration"></span></div>
				<span class="progress hidden">0</span>
				<span class="current-time hidden"></span>
				<span class="paused-state hidden">true</span>
				<span class="muted-state" hidden>false</span>
				<span class="height-width" hidden>-/-</span>
				<span class="network-state" hidden></span>
				<span class="ready-state" hidden></span>
				<span class="volume" hidden>1</span>
				<span class="height-width hidden">-/-</span>
			</div>
		</div>
		
		<div id="vidProgress">
			<div class="videoProgressBar" style="background-color:red;width:0;height:100%;"></div>
		</div>
		
		<div id="rotate" style="height:100%;width:100%;display:none;">
			<div style="color:white;">Rotate your device</div>
		</div>
		
		<nav class="footer action-bar fixed-bottom">
			<cfoutput>
			<strong style="color:##333;line-height:1em;font-size:1.1em;position:absolute;top:-30px;">Inhaltsverzeichnis</strong>
			<div class="ftScrollerlHorizontal" style="height:100%;" id="footerswiper"><cfloop from="1" to="12" index="i"><cfset p1 = "##/" /><cfset p2 = "##/0/1" /><cfset p3 = "##/0/2" /><cfset p4 = "##/0/3" /><cfset p5 = "##/1/0" /><cfset p6 = "##/2/0" /><cfset p7 = "##/2/1" /><cfset p8 = "##/3/0" />
					<div style="height:200px;float:left;width:300px;"> 
						<div style="height:100%;" class="swiperImage">
							&nbsp;
						</div>
						<strong onclick='closeTopMenu();location.href="#evaluate("p" & randRange(1,8))#";'>The Big Bang Theory</strong>
						<h1>Die Serie handelt von den zwei intelligenten jungen Physikern </h1><h2>Season 2</h2></div></cfloop>
				</div>
			</div>
			</cfoutput>
		</nav>
		
		<div class="loglog"></div>
	</cfif>
	
	<!--- load jQuery --->
	<script src="js/jquery-1-10-2.min.js"></script>
	<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="js/jquery.easing.1.3.js"></script>
	<!--- only load and init scripts when a single publication is chosen --->
	<cfif pubCount EQ 1 OR (session.pubID NEQ 0 AND session.issueID NEQ 0)>
		<!--- <script src="js/jquery.fittext.js"></script> --->
		<script src="js/fries.js"></script> 
		<!--- <script src="inc/flexslider/jquery.flexslider.js"></script> --->
		<script src="js/3.0.5/lib/klass.min.js"></script>
		<script src="js/3.0.5/code.photoswipe.jquery-3.0.5.min.js"></script>
		<script src="js/reveal.js-master/lib/js/head.min.js"></script>
		<script src="js/reveal.js-master/js/reveal.js?<cfoutput>#getTickCount()#</cfoutput>"></script>
		<!--- <script src="js/iscroll5/build/iscroll.js"></script> ---> 
		<script src='js/ftscroller-master/lib/ftscroller.js'></script>
		<!--- <script src="js/Swiper-master/dist/idangerous.swiper-2.4.min.js"></script> --->
		<!--- <script src="js/BigText-master/demo/js/jquery.ba-throttle-debounce.min.js"></script>
		<script src="js/BigText-master/demo/js/jquery.smartresize.js"></script> --->
		<!--- <script src="js/BigText-master/bigtext.js"></script>
		<script src="js/slabtext.js"></script> --->
		<script src="js/helpers.js"></script>
		<!--- <script src="js/tpl1.js"></script> --->
		<script src="js/tpl2.js"></script>
		<script src="js/tpl6.js"></script>
		<script src="js/tpl7.js"></script>
		<script src="js/tpl8.js"></script>
		<script src="js/scripts-reveal.js"></script>
		<!--- <script src="js/appcache.js"></script> --->
		<script>
			$(document).ready(function(){
				$('#loading').vAlign();
				
			});
			$(window).load(function(){
				startMag();
			})
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
				$('#loading').vAlign();
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
	
<cfelse>
	<form action="<cfoutput>#cgi.SCRIPT_NAME#?#session.urltoken#</cfoutput>" method="post">
		username <input type="text" name="user"><br/>
		password <input type="password" name="pass"><br/>
		<input type="submit" value="am Kiosk anmelden" />
	</form>	
</cfif>	
	
</body>
</html>
