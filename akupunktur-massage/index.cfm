<cfprocessingdirective pageencoding="utf-8" />
<!--- Template loader for MANDANT: APM akupunktur --->
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
	<cfset xpath = cgi.PATH_INFO />
	<cfif xpath EQ "/#session.serverpath#/index.cfm" OR xpath EQ "/#session.serverpath#/ch-de" OR xpath EQ "/#session.serverpath#/ch-de/">
		<cflocation url="http://#cgi.SERVER_NAME#" addtoken="no" />
	</cfif>
</cfif>

<!--- get service-nav oberstes level --->
<cfquery name="getServiceNav" datasource="#application.dsn#">
SELECT * FROM pages
WHERE navpos = 0 AND parentid = 0 AND isactive = 1 AND mandant = #session.mandant# AND lang = '#session.lang#'
ORDER	BY navorder
</cfquery>
<!--- get themen-nav oberstes level --->
<cfquery name="getThemenNav" datasource="#application.dsn#">
SELECT 	* FROM pages
WHERE 	navpos = 1 AND parentid = 0 AND isactive = 1  AND mandant = #session.mandant# AND lang = '#session.lang#'
ORDER	BY navorder
</cfquery>
<!--- get nav 2. level --->
<cfquery name="getsubnav" datasource="#application.dsn#">
SELECT 	* FROM pages
WHERE 	parentid = #listFirst(session.navtree)# AND isactive = 1 
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
<!--- get inhalte --->
<cfquery name="getcontent" datasource="#application.dsn#">
SELECT 	* FROM content
WHERE 	pageid = #url.id# AND isactive = 1
ORDER	BY reihenfolge
</cfquery>
<!--- get actual page properties --->
<cfquery name="pageProperties" datasource="#application.dsn#">
SELECT * FROM pages
WHERE id = #url.id# AND isactive = 1 
</cfquery>
<!--- get actual sidebars --->
<cfquery name="getSidebarElems" datasource="#application.dsn#">
SELECT 	S.* 
FROM 	sidebar2pages P LEFT JOIN sidebar S ON P.sidebarid = S.id
WHERE 	P.pageid = #url.id# AND S.isactive = 1 AND S.teaserposition = 1
ORDER	BY P.reihenfolge 
</cfquery>
<!--- get teasers --->
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

<!--- Get active Footer from current Mandant-ID  --->
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
	<!-- Remove this line if you use the .htaccess -->
	<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="robots" content="index,follow">	
	<meta name="revisit-after" content="30 days">
	<!--- 1. CHANGE CONTENT Description HERE --->
	<!--- <meta name="description" content="Akupunkturmassage Imbach APM">	 --->
	<!--- 2. CHANGE TITLE Description HERE --->
	<!--- <title>Akupunkturmassage APM nach Radloff Cecile Imbach - TESTsite</title> --->
	
<cfoutput>
	<link rel="shortcut icon" type="image/x-icon" href="/#session.serverpath#/favicon.ico">
	<link rel="shortcut icon" type="image/png" href="/#session.serverpath#/favicon.png">
	<link href='http://fonts.googleapis.com/css?family=Muli:400,400italic|Cinzel' rel='stylesheet' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/css/kube_f.css' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/js/FlexSlider/flexslider.css' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/css/apm-styles.css' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/css/mq-apm-style.css' type='text/css'> 
	<!--[if lt IE 9]>
	<link rel="stylesheet"  href="/#session.serverpath#/css/ie-apm-style.css" type="text/css"/>
	<![endif]-->

	<script src="/#session.serverpath#/js/jquery-2.0.3.min.js"></script>
	<script src="/#session.serverpath#/js/jquery.flexslider-min.js"></script>
<!--	<script src="/#session.serverpath#/js/scripts.js"></script>		-->
</cfoutput>
	
	
	<!--- push meta-tags dynamicly into html-head section --->
	<cfoutput>
	<cfhtmlhead text='
	<meta name="description" content="#pageProperties.metaDesc#">
	<meta name="keywords" content="#pageProperties.metaKeys#">
	<title>Praxis Akupunktur Massage | #pageProperties.metaTitel# | Cecile Imbach, Mellingen, Baden</title>
	' />		
	</cfoutput>
	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
</head>
<body>
<!-- Prompt IE 7 users to install Chrome Frame -->
<!--[if lt IE 8]><p class=chromeframe>Your browser is <em>ancient!</em> <a href="http://browsehappy.com/">Upgrade to a different browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to experience this site.</p><![endif]-->
<!--[if (gte IE 6)&(lte IE 8)]>	<script src="js/selectivizr.js"></script><![endif]-->
	
	<!--- <cfoutput>
		<script src="/#session.serverpath#/js/jquery-1.7.2.min.js"></script>
	    <script src="/#session.serverpath#/js/jquery.flexslider-min.js"></script>
	</cfoutput> --->
	
	<!--- include the APM main template  --->
	<cfinclude template="inc/template1.cfm" />
	<!-- Javascript - jQuery -->
	
	 <cfoutput>
		<script src="/#session.serverpath#/js/scripts.js"></script>		
	</cfoutput> 
	
	<!-- Asynchronous Google Analytics snippet. akupunktur-radloff als hauptdomain UA-xx-5 -->
	<script>
		 (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		 (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		 m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		 })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		 ga('create', 'UA-38956798-5', 'akupunktur-radloff.ch');
		 ga('send', 'pageview');
	</script>
	</body>
</html>