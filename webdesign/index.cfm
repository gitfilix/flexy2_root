<cfprocessingdirective pageencoding="utf-8" />
<!--- Template loader for MANDANT: Webkanal --->
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
	<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1 user-scalable=no">
	<meta name='robots' content='index,follow'>
	<meta name="revisit-after" content="20 days"/>
	<meta name="author" content="Webkanal, Felix Adam">
	<link type="text/plain" rel="author" href="/webdesign/humans.txt" />
<cfoutput>	
	<script src='/#session.serverpath#/js/modernizr.custom.29299.js'></script>
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Raleway:400,200' type="text/css" rel="stylesheet">

	<!-- First load resets, then cube-F-styles, then FLX-webkanal styles, and media querries at last -->
	<link rel='stylesheet' href='/#session.serverpath#/css/normalize.css' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/css/kube_f.css' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/js/bxslider/jquery.bxslider.css' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/css/webkanal-style.css' type='text/css'>
	<link rel='stylesheet' href='/#session.serverpath#/css/mq-webkanal-style.css' type='text/css'>
	<link rel="shortcut icon" type="image/x-icon" href="/#session.serverpath#/favicon32.ico">
	<link rel="shortcut icon" type="image/png" href="/#session.serverpath#/favicon32.png">
	<!-- push meta-tags dynamicly by flexypowers into html-head section -->
<cfhtmlhead text='
	<meta name="description" content="#pageProperties.metaDesc#">
	<meta name="keywords" content="#pageProperties.metaKeys#">
	<title>Webkanal | #pageProperties.metaTitel# | HTML5 Manufaktur | Bern</title>
	' />			
</cfoutput>
	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
</head>
<body>
<!-- Prompt IE 7 users to install Chrome Frame -->
<!--[if lt IE 8]><p class=chromeframe>Your browser is <em>VERY OLD!</em> <a href="http://browsehappy.com/">Upgrade to a different browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to experience this site.</p><![endif]-->
<!--[if (gte IE 6)&(lte IE 8)]>	<script src="js/selectivizr.js"></script><![endif]-->
		<!--- 	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
		<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> --->
<cfoutput>
	<!-- load from localhost Javascript - jQuery BEFORE webkanal HTML Code is rendered -->
	<script src='/#session.serverpath#/js/jquery-2.0.3.min.js'></script>
	<!--- <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> --->
	<script src="/#session.serverpath#/js/jquery-ui-1.10.3.custom.min.js"></script>
	<!--- <script src='/#session.serverpath#/js/jquery-ui.min.js'></script> --->
	<!--- <script src='/#session.serverpath#/js/jquery.flexslider-min.js'></script> --->
	<script src='/#session.serverpath#/js/bxslider/jquery.bxslider.js'></script>
	<script src="/#session.serverpath#/js/scripts.js"></script>	
	<!--- include the webkanal-main template1  --->
	<cfinclude template="inc/template1.cfm" />
	<!--POST renderScripts here executet AFTER webkanal html code is rendered -->
	<script src="/#session.serverpath#/js/scripts-postrender.js"></script>
</cfoutput>
		 
	<!-- Asynchronous Google Analytics snippet. New Webkanal id 4 -->
		<script type="text/javascript">
		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-38956798-4']);
		  _gaq.push(['_trackPageview']);
		  (function() {
			var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();
		</script>
	</body>
</html>