<cfprocessingdirective pageencoding="utf-8" />

<cfset idList = "259,260,261" />

<cfquery name="getSelectedPages" datasource="#application.dsn#">
SELECT	*
FROM	pages
WHERE 	id IN (#idList#)
</cfquery>

<cfset ownDomain = "webkanal.ch">

<!--- get service-nav oberstes level --->
<cfquery name="getServiceNav" datasource="#application.dsn#">
SELECT * FROM pages
WHERE navpos = 0 AND parentid = 0 AND isactive = 1 AND mandant = #session.mandant# AND lang = '#session.lang#'
ORDER	BY navorder
</cfquery>
<!--- get themen-nav oberstes level --->
<cfquery name="getThemenNav" datasource="#application.dsn#">
SELECT * FROM pages
WHERE navpos = 1 AND parentid = 0 AND isactive = 1  AND mandant = #session.mandant# AND lang = '#session.lang#'
ORDER	BY navorder
</cfquery>
<!--- get nav mobile oberstes level --->
<cfquery name="getNavMobile" datasource="#application.dsn#">
SELECT * FROM pages
WHERE parentid = 0 AND isactive = 1  AND mandant = #session.mandant# AND lang = '#session.lang#'
ORDER	BY navpos, navorder
</cfquery>
<!--- get nav 2. level --->
<cfquery name="getsubnav" datasource="#application.dsn#">
SELECT * FROM pages
WHERE parentid = #id# AND isactive = 1 
ORDER	BY navorder
</cfquery>
<!--- get FOOTER-nav oberstes level --->
<cfquery name="getFooterNav" datasource="#application.dsn#">
SELECT * FROM pages
WHERE 	navpos = 2
		AND parentid = 0 
		AND isactive = 1 
		AND mandant =#session.mandant#
		AND lang ="#session.lang#"
ORDER 	BY navorder
</cfquery>

<!--- get Footer --->
<cfquery name="getFooter" datasource="#application.dsn#">
SELECT 	*
FROM	footer
WHERE	mandant = #session.mandant#
		AND isactive = 1
</cfquery>



<!DOCTYPE html>

<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->

<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->

<head>
	<meta charset="UTF-8">
	<title>Magazin</title>
	
	<meta name ="viewport" content = "width = device-width, initial-scale = 1.0, user-scalable = no" />
	
	<cfoutput>
	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
	<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
	<!--- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript" charset="utf-8"></script>  --->
	<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
	<link rel="shortcut icon" type="image/png" href="favicon.png">
	<link href='http://fonts.googleapis.com/css?family=Raleway:400,200,300,500' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="/#session.serverpath#/css/style.css">
<link rel="stylesheet" href="/#session.serverpath#/css/mq.css">
	<link rel="stylesheet" href="/#session.serverpath#/css/kube.css">
	<link rel='stylesheet' href='/#session.serverpath#/inc/template1/js/flexslider/flexslider.css' type='text/css'> 
	<script src="/#session.serverpath#/js/jquery-pageswipe/pageswipe/jquery.pageswipe.js" type="text/javascript" charset="utf-8"></script>
	<script src="/#session.serverpath#/js/jquery.flexslider.js"></script>
	
	<script src='/#session.serverpath#/js/FlexSlider/jquery.flexslider-min.js'></script>
	<script  src="/#session.serverpath#/inc/yoxview/yoxview-init.js" type="text/javascript" ></script>
	</cfoutput>
	
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
  
	
	<script type="text/javascript" charset="utf-8">
$.fn.hasOverflow = function() {
    var $this = $(this);
    var $children = $this.find('*');
    var len = $children.length;

    if (len) {
        var maxWidth = 0;
        var maxHeight = 0
        $children.map(function(){
            maxWidth = Math.max(maxWidth, $(this).outerWidth(true));
            maxHeight = Math.max(maxHeight, $(this).outerHeight(true));
        });

        return maxWidth > $this.width() || maxHeight > $this.height();
    }

    return false;
};
		function jumpTo(nr){
			wert = (parseInt(nr)) * $(window).width();
			//$('.pages').css('MozTransform',"translateX(-"+wert+"px)");	 	
			$('.pages').css({
				 'MozTransition': 'transform 0s',
 				 'MozTransform': 'translateX(-'+wert+'px)',
				 'webkitTransition': 'transform 1s',
 				 'webkitTransform': 'translate3d(-'+wert+'px,0,0)'
			});
		}
		
		$(document).ready(function() {
			$('.pages').pageSwipe();
			
			
			
			$(window).resize(function(){
				$(".pages").unwrap();
				$('.pages').pageSwipe();
			});
			
			
			$('.pages').css({
				 'transition': 'transform 2s',
 				 'transform': 'translateX(0px)'
			});
			
			
			
			
	 })
	 
	 $(window).load(function(){
			$('.layoutElem').each(function(){
				
				if($(this).hasOverflow()){
					$(this).addClass('overflowed');
				}
			});
			
			$('.overflowed').unbind('touchstart,touchmove,tochend');
			$('.overflowed').bind('touchmove', function(e){
				alert(1);
				e.stopImmediatePropagation()
			}); 
	});
	</script>
	
	<style type="text/css" media="screen">
	 body {
	   margin: 0;
	   padding: 0;
	   background-color: #000;
	   font-family:'Raleway', sans-serif;
	   font-size:120%;
	 }
	 
	 div.page {
	   background-color: #fff;
	 }

	 div#frontpage {
	   background-color:#121212;
	   color:white;
	 }
   
   
   div.pages {
     -webkit-backface-visibility: hidden;
     -webkit-perspective: 1000;
   }
	</style>
	

  
</head>

<body>
<div style="height:50px;width:768px;margin:0 auto;position:relative;">
	<a href="javascript:void(0);" onclick="$('#menu').toggle();" style="display:block;margin-top:6px;margin-right:20px;width:36px;height:36px;border-radius:5px;background-color:yellow;color:white;float:left;">
		
	</a>
	<a href="javascript:void(0);" style="display:block;margin-top:6px;margin-right:20px;width:36px;height:36px;border-radius:5px;background-color:orange;color:white;float:left;">
		
	</a>
	<a href="javascript:void(0);" style="display:block;margin-top:6px;margin-right:20px;width:36px;height:36px;border-radius:5px;background-color:pink;color:white;float:left;">
		
	</a>
	<div style="clear:both;"></div>
	<div id="menu" style="background-color:darkred;width:100%;position:absolute;left:0;top:50px;display:none;z-index:2;">
		<div style="padding:30px;">
			<ul>
				<li style="float:left;">
					<a href="">
						Menü 1
					</a>
				</li>
				<li style="float:left;">
					<a href="">
						Menü 1
					</a>
				</li>
				<li style="float:left;">
					<a href="">
						Menü 1
					</a>
				</li>
			</ul> 
			<div style="clear:both;"></div>
		</div>
	</div>
</div>
<div class="pages">
  
	<div class="page" id="frontpage">
		<section style="padding:20px;font-size:1.3em;">
			<div class="title">Webkanal Frontpage</div>
			<div class="subtitle">Examples for creating an online magazine or book</div>
		</section>
	</div>
  
	<cfoutput query="getSelectedPages">
	
<!--- get actual page properties --->
<cfquery name="pageProperties" datasource="#application.dsn#">
SELECT * FROM pages
WHERE id = #id# AND isactive = 1 
</cfquery>
<!--- get inhalte --->
<cfquery name="getcontent" datasource="#application.dsn#">
SELECT * FROM content
WHERE pageid = #id# AND isactive = 1
ORDER	BY reihenfolge
</cfquery>
<!--- get actual sidebars --->
<cfquery name="getSidebarElems" datasource="#application.dsn#">
SELECT 	S.* 
FROM 	sidebar2pages P LEFT JOIN sidebar S ON P.sidebarid = S.id
WHERE 	P.pageid = #id# AND S.isactive = 1 AND S.teaserposition = 1
ORDER	BY P.reihenfolge 
</cfquery>
<!--- get teasers for position bottom--->
<cfquery name="getTeasers" datasource="#application.dsn#">
SELECT 	S.* 
FROM 	teaser2pages P LEFT JOIN sidebar S ON P.sidebarid = S.id
WHERE 	P.pageid = #id# AND S.isactive = 1 AND S.teaserposition = 2
ORDER	BY P.reihenfolge 
</cfquery>
<!--- get actual headerpanel --->
<cfquery name="getHeaderPanels" datasource="#application.dsn#">
SELECT 	S.* 
FROM 	headerpanels2pages H LEFT JOIN headerpanels S ON H.headerpanelID = S.id
WHERE 	H.pageid = #id# AND S.isactive = 1
ORDER	BY H.reihenfolge 
</cfquery>
<!--- getAllLinkedContentsFromCalledContentid --->
<cfquery name="getAllLinkedContentsFromPage" datasource="#application.dsn#">
SELECT 	linkedContentID,mainContentID
FROM 	contents2content
WHERE 	mainContentID IN (SELECT id FROM content WHERE pageid = #id#)
</cfquery>
		<div class="page">
			

		
				<div id="outer_wrapper" >	
					<div id="servicenavtop">
						
						<div class="langnav">
							<cfinclude template="inc/langnav.cfm">
						</div>	
						<div class="servicenav"> 
							<cfinclude template="inc/servicenav.cfm">
						</div>
						<div class="bluebartop">
							&nbsp;
						</div>	
						<div class="clear"></div>
					</div>
			
				</div>
				
				<!---inner wrapper for mq's --->
				<div id="inner_wrapper">	
					<!--- mobile navigations menue --->
					<div>
						<cfinclude template="inc/mobile_nav.cfm">
					</div>
					<!--- container Blue bar  --->
					<div id="BlueBar">
						<div class="bluepanel">
							<!--- 	include logo and flx test --->
							<cfinclude template="inc/logo.cfm">
							<!--- 	Themennav & include Subnav starts here --->
							<div class="themennav">
								<cfinclude template="inc/themennavplus.cfm">
							</div>
							<blockquote class="quotetext">
								<p>
									&laquo;Es soll die Aussage im Vordergrund stehen, das Handwerk im Hintergrund um die Qualität zu gewährliesten.&raquo;
								</p>
								<br />
								- Tim Berners Lee<br/> ("Erfinder" des Internets)
							</blockquote>
						</div>
					</div>	
					
					<div id="Header">
							<cfinclude template="inc/headerpanel.cfm">
					</div>
					<!--- Main content container start here : Content and sidebar --->
					<div id="contentwrapper">
						<div id="MainContent">	
							<cfinclude template="inc/content.cfm">
						</div>
						<div id="sidebar">
							<cfinclude template="inc/sidebars.cfm">
						</div>
						<div class="clear"></div>
						<!--- Bigfooter mit 3 Teasers --->
						<div id="footerbar">
							<div class="footercontainer">
								<cfinclude template="inc/footerteaser.cfm"> 
							</div>
						</div>
						<!--- smallfooter infos --->
						<div id="footer">
							<div class="footerbottom">
								<cfinclude template="inc/footer.cfm">
							</div>	
						</div>
					<!--- MainContainer container end --->
					</div>
					<div class="clear"></div>
				<!--- inner wrapper end --->
				</div>
			

		</div> 

	</cfoutput>
</div>

<script type="text/javascript" charset="utf-8">
	  $(window).load(function() {
  	  $('.flexslider').flexslider();
	 	if (jQuery().flexslider) {
		   $('.flexslider').flexslider({
			smoothHeight: true, 
			controlNav: false,         
			directionNav: false,  
			//prevText: "&larr;",
			//nextText: "&rarr;",
			selector: ".slides > .slide",
			animation:'fade'
		});
		};
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
	</script>

</body>
</html>
