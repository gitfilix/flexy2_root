<cfprocessingdirective pageencoding="utf-8" />

<cfparam name="url.pubid" default="21" />

<cfif isdefined("url.pubid")>
	<cfset pubid = url.pubid />
<cfelse>
	<cfset pubid = 21 />
</cfif>




<cfset matrix = fs.getInitialMatrix(issueID=pubid,startSlide=0) />

<cfquery name="getTemplates" datasource="#application.dsn#">
SELECT 	DISTINCT(template) as template
FROM	magazinausgaben A LEFT JOIN 
		magazinKapitel K ON K.magazinausgabeid = A.id LEFT JOIN
		magazinslides S ON parent = K.id
WHERE	A.id = 21
</cfquery>
<cfset templates = "" />
<cfoutput query="getTemplates">
	<cfif not listFind(templates,template)>
		<cfset templates = listAppend(templates,template) />
	</cfif>
</cfoutput>

<cfquery name="getChapters" datasource="#application.dsn#">
SELECT 	K.id, K.kapitel, K.id
FROM	magazinausgaben A LEFT JOIN 
		magazinKapitel K ON K.magazinausgabeid = A.id
WHERE	A.id = #url.pubid#
ORDER	BY reihenfolge
</cfquery>
<cfset chapters = 0 />
<cfset chapterTitles = "" />
<cfset chapterIDs = "" />
<cfoutput query="getChapters">
	<cfset chapters ++ />
	<cfset chapterTitles = listAppend(chapterTitles,kapitel) />
	<cfset chapterIDs = listAppend(chapterIDs,id) />
</cfoutput>

<!DOCTYPE HTML>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>dia</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /> 
	<meta name="apple-mobile-web-app-capable" content="yes">
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="css/slideplugin.jquery.css" />
	<link rel="stylesheet" href="css/styles.css" />
	<link rel='stylesheet' href='css/kube_f.css' type='text/css'>
	<link rel='stylesheet' href='css/kube_overrides.css' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800,300' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Playfair+Display:400,400italic,700italic' rel='stylesheet' type='text/css'>
	<link rel='stylesheet' href='inc/swiper-master/dist/idangerous.swiper.css' type='text/css'>
	
	<!--- template specific css --->
	<cfoutput>
		<cfloop list="#templates#" index="i">
			<cfif fileExists(expandPath('/dia/inc/templates/') & "tpl-#i#.css")>
	<link rel="stylesheet" href="/dia/inc/templates/tpl-#i#.css" type="text/css" />
			</cfif>
		</cfloop>
	</cfoutput>
	
	<script src="js/modernizr.js"></script>
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script src='js/easing.js'></script>
	
	<script src="js/overthrow-detect.js"></script>
	<script src="js/overthrow-polyfill.js"></script>
	<script src="js/overthrow-toss.js"></script>
	<script src="js/overthrow-init.js"></script>
	
	<script src="inc/swiper-master/dist/idangerous.swiper.min.js"></script>
	
	<script src='inc/ftscroller-master/lib/ftscroller.js'></script>
	<script src="js/slideplugin.jquery.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
	<script type="text/javascript" src="js/gmaps/gmaps.js"></script>
	<script type="text/javascript" src="js/jquery.center.min.js"></script>
	
	<!--- template specific js --->
	<cfoutput>
		<cfloop list="#templates#" index="i">
			<cfif fileExists(expandPath('/dia/inc/templates/') & "/tpl-#i#.js")>
	<script src="/dia/inc/templates/tpl-#i#.js" type="text/javascript"></script>
			</cfif>
		</cfloop>
	</cfoutput>
	<script src="js/scripts.js"></script>
	
</head>
<body style="position:relative;background:white;height:100%;overflow:hidden;">
	
	
	
	<cfoutput>
		<div id="wrapper">	
			<ul id="mag-wrapper" style="position:relative;left:0;top:0;">
				<li class="mainslide" id="leftSlide">
					<ul class="subslides">
						<li class="subslide" style="background:white;height:100%;"></li>
						<li class="subslide" style="background:white;height:100%;"></li>
						<li class="subslide" style="background:white;height:100%;"></li>
					</ul>
				</li>
				<li class="mainslide" id="centerSlide" data-chapterid="#matrix[3].chapterid#" data-nextchapterid="#matrix[4].chapterid#">
					<ul class="subslides">
						<li class="subslide" style="background:white;height:100%;"></li>
						<li data-id="#matrix[3].slides[3]#" <cfif arrayLen(matrix[3].slides) GTE 4 AND matrix[3].slides[4] NEQ 0>data-nextID="#matrix[3].slides[4]#"</cfif> class="subslide activeSlide" style="position:relative;height:100%;background:silver;">						
							<cfset templateID = fs.getSlide(slideID=matrix[3].slides[3]).template />
							<cfset url.slideID = matrix[3].slides[3] />
							<cfinclude template="/dia/inc/templates/template-#templateID#.cfm" />		
						</li>
						<li <cfif arrayLen(matrix[3].slides) GTE 4 AND matrix[3].slides[4] NEQ 0>data-id="#matrix[3].slides[4]#"</cfif> <cfif arrayLen(matrix[3].slides) GTE 5 AND matrix[3].slides[5] NEQ 0>data-nextID="#matrix[3].slides[5]#"</cfif> <cfif arrayLen(matrix[3].slides) GTE 4 AND matrix[3].slides[4] NEQ 0>data-prevID="#matrix[3].slides[3]#"</cfif> class="subslide" style="position:relative;height:100%;">
							<cfif arrayLen(matrix[3].slides) GTE 4 AND matrix[3].slides[4] NEQ 0>
								<cfset templateID = fs.getSlide(slideID=matrix[3].slides[4]).template />
								<cfset url.slideID = matrix[3].slides[4] />
								<cfinclude template="/dia/inc/templates/template-#templateID#.cfm" />	
							</cfif>
						</li>
					</ul>
				</li>
				<li class="mainslide" id="rightSlide" data-chapterid="#matrix[4].chapterid#" data-nextchapterid="#matrix[5].chapterid#" data-prevchapterid="#matrix[3].chapterid#">
					<ul class="subslides">
						<li class="subslide" style="background:white;height:100%;"></li>
						<li data-id="#matrix[4].slides[1]#" <cfif arrayLen(matrix[4].slides) GTE 2 AND matrix[4].slides[2] NEQ 0>data-nextID="#matrix[4].slides[2]#"</cfif>  class="subslide" style="background:silver;height:100%;">
							<cfset templateID = fs.getSlide(slideID=matrix[4].slides[1]).template />
							<cfset url.slideID = matrix[4].slides[1] />
							<cfinclude template="inc/templates/template-#templateID#.cfm" />	
						</li>
						
					</ul>
				</li>
			</ul>
			<div style="clear:both;"></div>
		</div>
	</cfoutput>
	<cfinclude template="inc/app.cfm" />
	

	
</body>
</html>
