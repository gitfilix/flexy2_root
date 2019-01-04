<cfprocessingdirective pageencoding="utf-8" />
<!--- Template loader for MANDANT: --->
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
ORDER	BY navorder DESC
</cfquery>
<!--- get themen-nav oberstes level --->
<cfquery name="getThemenNav" datasource="#application.dsn#">
SELECT 	* FROM pages
WHERE 	navpos = 1 AND parentid = 0 AND isactive = 1  AND mandant = #session.mandant# AND lang = '#session.lang#'
ORDER	BY navorder DESC
</cfquery>
<!--- get subnav 2. level --->
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
<!--- get all Teammembers of Mandant --->
<cfquery name="getTeammembers" datasource="#application.dsn#">
SELECT *
FROM	Teammembers
WHERE	parentCategory = 3
ORDER	BY id
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
<!--- get all TeamMembers from Mandant --->
<cfquery name="getTeam" datasource="#application.dsn#">
SELECT 	K.label,K.id as tid,T.*
FROM 	teamcategories K LEFT JOIN
		teammembers T ON T.parentCategory = K.id AND T.isActive = 1
WHERE 	K.mandant = #session.mandant# AND 
		K.isactive = 1
		<cfif isdefined("url.team")>AND T.id = #url.team#</cfif>
ORDER	BY K.reihenfolge
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
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=yes">
	<meta name="robots" content="noindex,nofollow">	
	<!--- 1. CHANGE CONTENT Description HERE --->
	<meta name="description" content="TSM 15 Medien Heroes">	
	<!--- 2. CHANGE TITLE Description HERE --->
	<title>TSM15 - Media SUPER HEROES - NETMAN beats MEDIA DEVIL HERE AGAIN! And AGAIN- Take this Title-META-TAG: KA-WoooM! TSCHAGA!</title>
	<!--- 3. CHANGE FAVICON HERE --->
	<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
	<link rel="shortcut icon" type="image/png" href="favicon.png">
	

	<!--some like it local, yes even javascript versions -->
	<cfoutput>
	 <script src="/#session.serverpath#/js/jquery-2.0.3.min.js"></script> 
	 </cfoutput>
	<!--- include typekit webfont here --->
	<script type="text/javascript" src="//use.typekit.net/oog6wko.js"></script>
	<script type="text/javascript">try{Typekit.load();}catch(e){}</script>
	
	<cfoutput>
	<link rel='stylesheet' href='/#session.serverpath#/css/kube_f.css' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/css/animate-custom.css' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/css/hero-style.css' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/css/mq-hero-style.css' type='text/css'>
	</cfoutput>

	
	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
</head>
<body>
<!-- Prompt IE 7 users to install Chrome Frame -->
<!--[if lt IE 8]><p class=chromeframe>Your browser is <em>ancient!</em> <a href="http://browsehappy.com/">Upgrade to a different browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to experience this site.</p><![endif]-->
<!--[if (gte IE 6)&(lte IE 8)]>	<script src="js/selectivizr.js"></script><![endif]-->
	<!--- include the main HERO template  --->
	
	<cfinclude template="inc/template.cfm" />
	<!-- Javascript - jQuery -->
	
	<cfoutput>
		<!--- <script src='/#session.serverpath#/js/jquery.flexslider-min.js'></script> --->
		<!---	<script src='/#session.serverpath#/inc/yoxview/jquery.yoxview-2.21.min.js'></script>--->
		<script src="/#session.serverpath#/js/scripts.js"></script>	
		<script>
	
		</script>	
	</cfoutput>
	
	<!-- Asynchronous Google Analytics snippet. Change UA-XXXXX-X to be your site's ID. -->
	<!--- <script>
	  var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
	  (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
	  g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
	  s.parentNode.insertBefore(g,s)}(document,'script'));
	</script> --->
	</body>
</html>