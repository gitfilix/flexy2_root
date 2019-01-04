<cfprocessingdirective pageencoding="utf-8" />

<!--- get mag pages --->
<cfquery name="getPages" datasource="#application.dsn#">
SELECT	P.id as pid, P.pagetitel as ppagetitel,P.navtitel as pnavtitel,
		Pa.id as paid, Pa.pagetitel as papagetitel,Pa.navtitel as panavtitel,
		Pb.id as pbid, Pb.pagetitel as pbpagetitel,Pb.navtitel as pbnavtitel,
		Pc.id as pcid, Pc.pagetitel as pcpagetitel,Pc.navtitel as pcnavtitel,
		Pd.id as pdid, Pd.pagetitel as pdpagetitel,Pd.navtitel as pdnavtitel
FROM	(((pages P LEFT JOIN 
		pages Pa ON Pa.parentID = P.id AND Pa.isActive = 1 AND <cfif session.cugLoggedIn EQ 0>Pa.id NOT IN (SELECT pageid FROM usergroups2pages WHERE pageID = Pa.id)<cfelse>(Pa.id IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = Pa.id AND G.userGroupId = #session.cug.groupID#) OR Pa.id NOT IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = Pa.id))</cfif>) LEFT JOIN
		pages Pb ON Pb.parentID = pa.id AND Pb.isActive = 1 AND <cfif session.cugLoggedIn EQ 0>Pb.id NOT IN (SELECT pageid FROM usergroups2pages WHERE pageID = Pb.id)<cfelse>(Pb.id IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = Pb.id AND G.userGroupId = #session.cug.groupID#) OR Pb.id NOT IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = Pb.id))</cfif>) LEFT JOIN
		pages Pc ON Pc.parentID = pb.id AND Pc.isActive = 1 AND <cfif session.cugLoggedIn EQ 0>Pc.id NOT IN (SELECT pageid FROM usergroups2pages WHERE pageID = Pc.id)<cfelse>(Pc.id IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = Pc.id AND G.userGroupId = #session.cug.groupID#) OR Pc.id NOT IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = Pc.id))</cfif>) LEFT JOIN
		pages Pd ON Pd.parentID = pc.id AND Pd.isActive = 1 AND <cfif session.cugLoggedIn EQ 0>Pd.id NOT IN (SELECT pageid FROM usergroups2pages WHERE pageID = Pd.id)<cfelse>(Pd.id IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = Pd.id AND G.userGroupId = #session.cug.groupID#) OR Pd.id NOT IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = Pd.id))</cfif>
WHERE 	P.parentid = 0 AND 
		P.isactive = 1 AND 
		P.mandant = #session.mandant# AND 
		P.lang = '#session.lang#' AND
		<cfif session.cugLoggedIn EQ 0>
		P.id NOT IN (SELECT U.pageid FROM usergroups2pages U WHERE U.pageID = P.id)
		<cfelse>
		(P.id IN (SELECT U.pageid FROM usergroups2pages U WHERE U.pageID = P.id AND U.userGroupId = #session.cug.groupID#) OR P.id NOT IN (SELECT F.pageid FROM usergroups2pages F WHERE F.pageID = P.id))
		</cfif>
ORDER	BY P.navorder, P.id, Pa.id, Pb.id, Pc.id, Pd.id
</cfquery>

<!DOCTYPE html>

<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->

<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->

<head>
	<meta charset="UTF-8">
	<title>Magazin</title>
	
	<meta name = "viewport" content = "width = device-width, initial-scale = 1.0, user-scalable = no" />
	
	<cfoutput>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
	<link rel="shortcut icon" type="image/png" href="favicon.png">
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="/#session.serverpath#/css/style.css">
	<link rel='stylesheet' href='/#session.serverpath#/inc/template1/js/flexslider/flexslider.css' type='text/css'>
	
	<script src="inc/jquery-pageswipe/pageswipe/jquery.pageswipe.js" type="text/javascript" charset="utf-8"></script>
	<script src='/#session.serverpath#/inc/template1/js/FlexSlider/jquery.flexslider-min.js'></script>
	<script type="text/javascript" src="/#session.serverpath#/inc/yoxview/yoxview-init.js"></script></cfoutput>
	
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
  
	
	<script type="text/javascript" charset="utf-8">
	 $(document).ready(function() {
 	   $('.pages').pageSwipe();
	   
	   $(window).resize(function(){
			$(".pages").unwrap();
			$('.pages').pageSwipe();
		});
		
		
			$(".yoxview").yoxview({
				lang: "de",
				autoHideInfo: false,
				autoHideMenu: false
				
			});
			if (jQuery().flexslider) {
			   $('.flexslider').flexslider({
					smoothHeight: true, 
					controlNav: true,           
					directionNav: false,  
					prevText: "&larr;",
					nextText: "&rarr;",
					selector: ".slides > .slide"
				});
			};
	
		
	 })
	</script>
	
	<style type="text/css" media="screen">
	 body {
	   margin: 0;
	   padding: 0;
	   background-color: #000;
	   font-family: "PT Sans";
	   font-size:120%;
	 }
	 
	 div.page {
	   background-color: #fff;
	 }
	 
	 img{

		 }
	
	 
	 div#frontpage {
	   background-color: #121212;
	   color:white;
	 }
   
   div.pages {
     -webkit-backface-visibility: hidden;
     -webkit-perspective: 1000;
   }
	</style>
	
	<link href='http://fonts.googleapis.com/css?family=PT+Sans:400italic,400,700,700italic' rel='stylesheet' type='text/css' />

  
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
			<div class="title">Our frontpage</div>
			<div class="subtitle">Examples for creating an online magazine or book</div>
		</section>
	</div>
  
	<cfoutput query="getPages" group="pid">
	<cfif ppagetitel NEQ "">
		<div class="page">
			<section style="padding:30px;">
			<h1>#ppagetitel#</h1>
			<!--- get inhalte --->
			<cfquery name="getcontent" datasource="#application.dsn#">
			SELECT 	* 
			FROM 	content
			WHERE 	pageid = #pid#
			ORDER	BY reihenfolge
			</cfquery>
			<!--- get actual page properties --->
			<cfquery name="pageProperties" datasource="#application.dsn#">
			SELECT * FROM pages
			WHERE id = #pid#
			</cfquery>
			<!--- get all News from Mandant --->
			<cfquery name="getnews" datasource="#application.dsn#">
			SELECT 	* 
			FROM 	news
			WHERE 	mandant = #session.mandant# AND 
					isactive = 1
			</cfquery>
			<!--- get all TeamMembers from Mandant --->
			<cfquery name="getTeam" datasource="#application.dsn#">
			SELECT 	K.label,K.id as tid,T.*
			FROM 	teamcategories K LEFT JOIN
					teammembers T ON T.parentCategory = K.id AND T.isActive = 1
			WHERE 	K.mandant = #session.mandant# AND 
					K.isactive = 1
			ORDER	BY K.reihenfolge
			</cfquery>
			<!--- get actual headerpanel --->
			<cfquery name="getHeaderPanels" datasource="#application.dsn#">
			SELECT 	S.* 
			FROM 	headerpanels2pages H LEFT JOIN headerpanels S ON H.headerpanelID = S.id
			WHERE 	H.pageid = #pid# AND S.isactive = 1
			ORDER	BY H.reihenfolge 
			</cfquery>
			<cfif pageProperties.headerbild NEQ "" OR getHeaderPanels.recordcount GT 0>
				<div style="margin-bottom:3em;">
				
					<cfif pageProperties.headerbild NEQ "">
						<img src="/#session.serverpath#/upload/img/#pageProperties.headerbild#" alt="" style="width:100%;" />
					<cfelse>
						 <div class="flexslider">
							 <div class="slides">
							 
							<cfloop query="getHeaderPanels">
							  <div class="slide">
							   <img src="/#session.serverpath#/upload/img/headerpanel/#image#" />
								<div style="position:absolute;left:1em;bottom:1em;width:60%;background-color:white;padding:1.5em;opacity:0.8;font-size:18px;line-height:28px;">
									<strong style="font-size:28px;">#titel#</strong><br />
									#fliesstext#<br/>
									<a href="##">ein Links</a>
								</div>
							</div>
							</cfloop>
						  </div>
						</div>
					</cfif>
				</div>
			</cfif>
			<cfloop query="getcontent">
				<article>
					<header>
						<h1>#titel#</h1>
					</header>

					<cfif bildname NEQ "">
						<cfswitch expression="#imagepos#">
							<cfcase value="0">
								<cfif  fliesstextspalten EQ 1>
									<figure style="float:left;margin-right:1.5em;width:30%;margin-left:0;margin-top:0;">
										<img src="/#session.serverpath#/upload/img/#bildname#" alt="" style="width:100%;" class="fnc fnc-content-bildname-#session.mandant#-image-#id#">
										<figcaption>
											<span style="font-style:italic;">#imagecaption#</span>
										</figcaption>
									</figure> 
								</cfif>
							</cfcase>
							<cfcase value="1">
								<cfif  fliesstextspalten EQ 1>
									<figure style="float:right;margin-left:1.5em;width:30%;">
										<img src="/#session.serverpath#/upload/img/#bildname#" alt="" style="width:100%;" class="fnc fnc-content-bildname-#session.mandant#-image-#id#">
										<figcaption>
											<span style="font-style:italic;">#imagecaption#</span>
										</figcaption>
									</figure> 
								</cfif>
							</cfcase>
							<cfcase value="2">
								<div style="margin-bottom:1.5em;">
									<img src="/#session.serverpath#/upload/img/#bildname#" alt="" style="width:100%;" class="fnc fnc-content-bildname-#session.mandant#-image-#id#">
									<span style="font-style:italic;">#imagecaption#</span>
								</div>
							</cfcase>
							<cfdefaultcase>
								<figure style="float:left;margin-right:1.5em;width:30%;margin-left:0;margin-top:0;">
									<img src="/#session.serverpath#/upload/img/#bildname#" alt="" style="width:300px;" class="fnc fnc-content-bildname-#session.mandant#-image-#id#">
								</figure> 
							</cfdefaultcase>
						</cfswitch>
					</cfif>
					
					<cfif  fliesstextspalten GT 1 AND imagepos LT 2>
						<figure style="float:<cfif imagepos EQ 0>left<cfelseif imagepos EQ 1>right</cfif>;margin-right:1.5em;width:30%;margin-left:0;margin-top:0;">
							<img src="/#session.serverpath#/upload/img/#bildname#" alt="" style="width:100%;" class="fnc fnc-content-bildname-#session.mandant#-image-#id#">
							<figcaption>
								<span style="font-style:italic;">#imagecaption#</span>
							</figcaption>
						</figure> 
					</cfif>
					
					<p style="font-weight:700;">
						#lead#
					</p>
					<br/>
					<cfif fliesstext NEQ "" AND fliesstext NEQ "<br />">
						<div class="flexyCols-#fliesstextspalten#">
							<p>
								#fliesstext#
							</p>	
						</div>	
						<br/>
					</cfif>
					
					<cfquery name="getLinksAdded" datasource="#application.dsn#">
					SELECT 	*
					FROM	links2pages
					WHERE	contentid = #id#
					</cfquery>
					<cfif getLinksAdded.recordcount GT 0 OR href NEQ "">
					<br/>
					<h3 style="margin-bottom:0.2em;">Weiterführende Links</h3>
					</cfif>
					<cfif getLinksAdded.recordcount GT 0 OR href NEQ "">
					<ul class="contentSortable">
						<cfif href NEQ "">	
							<li class="fnc fnc-content-href-#session.mandant#-inputtext-#id#">
								<a href="#href#" target="_blank" style="display:block;">
									<div style="width: 0; height: 0; border-top: 5px solid transparent;border-bottom: 5px solid transparent;border-left: 5px solid ##0078CF;float:left;margin-top:7px;margin-right:0.5em;"></div> #hreflabel#
								</a>
							</li>
						</cfif>
						<cfif getLinksAdded.recordcount GT 0>
							<cfloop query="getLinksAdded">
								<li class="fnc fnc-links2pages-href-#session.mandant#-inputtext-#id#">
									<a href="#href#" target="_blank" style="display:block;">
										<div style="width: 0; height: 0; border-top: 5px solid transparent;border-bottom: 5px solid transparent;border-left: 5px solid ##0078CF;float:left;margin-top:7px;margin-right:0.5em;"></div> #hreflabel#
									</a>
								</li>
							</cfloop>
						</cfif>
					</ul>
					<br/>
					</cfif>
					<cfquery name="getDocsAdded" datasource="#application.dsn#">
					SELECT 	*
					FROM	docs2pages
					WHERE	contentid = #id#
					</cfquery>
					<cfif getDocsAdded.recordcount GT 0 OR doc NEQ "">
					<br/>
					<h3 style="margin-bottom:0.2em;">Dokumente / Downloads</h3>
					</cfif>
					<cfif getDocsAdded.recordcount GT 0 OR doc NEQ "">
					<ul class="contentSortable">
					<cfif doc NEQ "">	
						<li class="fnc fnc-content-doc-#session.mandant#-document-#id#">
							<a href="/#session.serverpath#/upload/doc/#doc#" target="_blank" style="display:block;">
								<div style="width: 0; height: 0; border-top: 5px solid transparent;border-bottom: 5px solid transparent;border-left: 5px solid ##0078CF;float:left;margin-top:7px;margin-right:0.5em;"></div> #doclabel#
							</a>
						</li>
					</cfif> 
					<cfif getDocsAdded.recordcount GT 0>
						<cfloop query="getDocsAdded">
							<li class="fnc fnc-docs2pages-dok-#session.mandant#-document-#id#">
								<a href="#dok#" target="_blank" style="display:block;">
									<div style="width: 0; height: 0; border-top: 5px solid transparent;border-bottom: 5px solid transparent;border-left: 5px solid ##0078CF;float:left;margin-top:7px;margin-right:0.5em;"></div> #doklabel# (#ucase(listLast(dok,'.'))#, #decimalFormat(size/1000000)# MB.)
								</a>
							</li>
						</cfloop>
					</cfif>
					</ul>	
					<br/>
					</cfif>
		
				</article>
			</cfloop>
			
		
			<!--- News comes here --->
			<cfif pageProperties.showAllNews EQ 1>
				<h2>News</h2>
				<cfloop query="getnews">
					<article class="news-elem disabled" style="margin-bottom:1em;border-bottom: 1px solid ##DDD;padding-bottom:2em;">
						<span class="news-date">#dateFormat(datum,"dd.mm.yyyy")#</span>
						<h3>#titel#</h3>
						<p>#fliesstext#</p>
					</article>
				</cfloop>
			</cfif>
			<!--- Team comes here --->
			<cfif pageProperties.showTeam EQ 1>
				<h2>Team</h2>
				<cfinclude template="/#session.serverpath#/inc/team.cfm" />
			</cfif>
			</section>
		</div> 
	</cfif>
	</cfoutput>
</div>

</body>
</html>
