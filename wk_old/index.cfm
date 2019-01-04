<cfprocessingdirective pageencoding="utf-8" />
<!--- check for own domain --->
<cfquery name="getDomain" datasource="#application.dsn#">
SELECT 	* 
FROM 	mandantensprachen
WHERE 	mandant = #session.mandant# AND domain != ''
</cfquery>

<cfset ownDomain = "" />
<cfif getDomain.recordcount GT 0>
	<cfset ownDomain = getDomain.domain />
</cfif>

<cfif ownDomain NEQ "">
	<cfset xpath = GetHttpRequestData().headers['x-request-uri'] />
	<cfif xpath EQ "/#session.serverpath#/index.cfm" OR xpath EQ "/#session.serverpath#/ch-de" OR xpath EQ "/#session.serverpath#/ch-de/">
		<cflocation url="http://#cgi.SERVER_NAME#" addtoken="no" />
	</cfif>
</cfif>

<!--- get service-nav oberstes level --->
<cfquery name="getServiceNav" datasource="#application.dsn#">
SELECT 	* FROM pages
WHERE 	navpos = 0 AND parentid = 0 AND isactive = 1 AND mandant = #session.mandant# AND lang = '#session.lang#'
ORDER	BY navorder
</cfquery>
<!--- get themen-nav oberstes level --->
<cfquery name="getThemenNav" datasource="#application.dsn#">
SELECT 	* FROM pages
WHERE 	navpos = 1 AND parentid = 0 AND isactive = 1  AND mandant = #session.mandant# AND lang = '#session.lang#'
ORDER	BY navorder
</cfquery>
<!--- get nav mobile oberstes level --->
<cfquery name="getNavMobile" datasource="#application.dsn#">
SELECT 	* FROM pages
WHERE 	parentid = 0 AND isactive = 1  AND mandant = #session.mandant# AND lang = '#session.lang#'
ORDER	BY navpos, navorder
</cfquery>
<!--- get nav 2. level --->
<cfquery name="getsubnav" datasource="#application.dsn#">
SELECT 	* FROM pages
WHERE 	parentid = #url.id# AND isactive = 1 
ORDER	BY navorder
</cfquery>
<!--- get FOOTER-nav oberstes level --->
<cfquery name="getFooterNav" datasource="#application.dsn#">
SELECT 	* FROM pages
WHERE 	navpos = 2
		AND parentid = 0 
		AND isactive = 1 
		AND mandant =#session.mandant#
		AND lang ="#session.lang#"
ORDER 	BY navorder
</cfquery>
<!--- get inhalte --->
<cfquery name="getcontent" datasource="#application.dsn#">
SELECT 	* FROM content
WHERE 	pageid = #url.id# AND isactive = 1
ORDER	BY reihenfolge
</cfquery>
<!--- get actual page properties --->
<cfquery name="pageProperties" datasource="#application.dsn#">
SELECT 	* FROM pages
WHERE 	id = #url.id# AND isactive = 1 
</cfquery>
<!--- get actual sidebars --->
<cfquery name="getSidebarElems" datasource="#application.dsn#">
SELECT 	S.* 
FROM 	sidebar2pages P LEFT JOIN sidebar S ON P.sidebarid = S.id
WHERE 	P.pageid = #url.id# AND S.isactive = 1 AND S.teaserposition = 1
ORDER	BY P.reihenfolge 
</cfquery>
<!--- get teasers for position bottom--->
<cfquery name="getTeasers" datasource="#application.dsn#">
SELECT 	S.* 
FROM 	teaser2pages P LEFT JOIN sidebar S ON P.sidebarid = S.id
WHERE 	P.pageid = #url.id# AND S.isactive = 1 AND S.teaserposition = 2
ORDER	BY P.reihenfolge 
</cfquery>
<!--- get actual headerpanel --->
<cfquery name="getHeaderPanels" datasource="#application.dsn#">
SELECT 	S.* 
FROM 	headerpanels2pages H LEFT JOIN headerpanels S ON H.headerpanelID = S.id
WHERE 	H.pageid = #url.id# AND S.isactive = 1
ORDER	BY H.reihenfolge 
</cfquery>
<!--- getAllLinkedContentsFromCalledContentid --->
<cfquery name="getAllLinkedContentsFromPage" datasource="#application.dsn#">
SELECT 	linkedContentID,mainContentID
FROM 	contents2content
WHERE 	mainContentID IN (SELECT id FROM content WHERE pageid = #url.id#)
</cfquery>
<!--- get all News from Mandant --->
<cfquery name="getnews" datasource="#application.dsn#">
SELECT 	* 
FROM 	news
WHERE 	mandant = #session.mandant# AND 
		isactive = 1
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
<!--[if gt IE 8]><!--> <html class="no-js" lang="de"> <!--<![endif]-->

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width; initial-scale=1.0; " /> 
	<meta name="robots" content="noindex,nofollow">
	<title>WEB Kanal - HTML5 Webdesign</title>

	<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
	<link rel="shortcut icon" type="image/png" href="favicon.png">
	
	<cfoutput>
	<link href='http://fonts.googleapis.com/css?family=Raleway:400,200,300,500' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="/#session.serverpath#/css/kube.css">
	<link rel="stylesheet" href="/#session.serverpath#/css/style.css">
	<link rel="stylesheet" href="/#session.serverpath#/css/mq.css">
	<!--- 	<link rel="stylesheet" href="/#session.serverpath#/css/flexslider.css">  --->
	<script src="/#session.serverpath#/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>
	</cfoutput>
	
	<!--[if (gte IE 6)&(lte IE 8)]>
	<script src="js/selectivizr.js"></script>
	<![endif]-->
	
	<!--[if lt IE 9]>
		<link rel="stylesheet" href="/#session.serverpath#/css/style_IE_hacks.css">
		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<script type="text/javascript">
			alert('Ich bin ein IE unter Version 9');
		</script>
	<![endif]-->
	
</head>
<body>
	<!-- Prompt IE 7 users to install Chrome Frame -->
	<!--[if lt IE 8]><p class=chromeframe>Your browser is <em>ancient!</em> <a href="http://browsehappy.com/">Upgrade to a different browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to experience this site.</p><![endif]-->
	
	<!--- Include template 1 webkanal here  --->
	<!--- 	<div id="rotatePhone">
		ROTATE YOUR PHONE
	</div> --->
	
	<cfinclude template="inc/template1.cfm" />
	
	<!--- Javascript --->
	<cfoutput>
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>	 
		<script src="/#session.serverpath#/js/jquery.flexslider.js"></script>
		<script src="/#session.serverpath#/js/jquery.html5forms.js"></script>
		<script src="/#session.serverpath#/inc/yoxview/yoxview-init.js"></script>
		<script src="/#session.serverpath#/js/scripts.js"></script>
	
		// google analytics
		<script type="text/javascript">
		 (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		
		  ga('create', 'UA-38956798-3', 'web-kanal.ch');
		  ga('send', 'pageview');
		</script>
		
	</cfoutput>
</body>
</html>