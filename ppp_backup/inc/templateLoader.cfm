<cfprocessingdirective pageencoding="utf-8" />
<!--- TEMPLATE LOADER für Mandant PPP --->
<!--- get service-nav oberstes level --->


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

<!--- parentUser in der WhereClause ausgeschlossen, da sonst Resulset = 0  --->
<!--- Mandant = serverpath, damit nur die Mandanten Navigations Punkte ausgewählt werden.  --->
<!--- <cfquery name="getServiceNav" datasource="#application.dsn#">
SELECT * FROM pages
WHERE 	navpos = 0
		AND parentid = 0
		AND isactive = 1 
		AND mandant = #session.mandant#
		AND lang ="#session.lang#"
ORDER 	BY navorder
</cfquery> --->

<!--- get service-nav oberstes level mit CUG login  --->
<cfquery name="getServiceNav" datasource="#application.dsn#">
SELECT 	P.*
FROM 	pages P
WHERE 	P.navpos = 0 AND 
		P.parentid = 0 AND 
		P.isactive = 1 AND 
		P.mandant = #session.mandant# AND 
		P.lang = '#session.lang#' AND
		<cfif session.cugLoggedIn EQ 0>
		P.id NOT IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = P.id)
		<cfelse>
		(P.id IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = P.id AND G.userGroupId = #session.cug.groupID#) OR P.id NOT IN (SELECT G.pageid FROM usergroups2pages G WHERE G.pageID = P.id))
		</cfif>
ORDER	BY P.navorder 
</cfquery>


<!--- get themen-nav oberstes level --->
<cfquery name="getThemenNav" datasource="#application.dsn#">
SELECT * FROM pages
WHERE 	navpos = 1
		AND parentid = 0 
		AND isactive = 1 
		AND mandant =#session.mandant#
		AND lang ="#session.lang#"
ORDER 	BY navorder
</cfquery>

<!--- get nav 2. level --->
<cfquery name="getsubnav" datasource="#application.dsn#">
SELECT * FROM pages
WHERE 	parentid = #listfirst(session.navtree)# 
		AND isactive = 1 
ORDER 	BY navorder
</cfquery>


<!--- get inhalte --->
<cfquery name="getcontent" datasource="#application.dsn#">
SELECT * FROM content
WHERE pageid = #url.id# 
		AND isactive = 1
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
WHERE 	P.pageid = #url.id# AND S.isactive = 1 AND teaserposition = 1
ORDER	BY P.reihenfolge 
</cfquery>

<!--- get actual teasers / bottom-elems --->
<cfquery name="getTeaserElems" datasource="#application.dsn#">
SELECT 	S.* 
FROM 	teaser2pages P LEFT JOIN sidebar S ON P.sidebarid = S.id
WHERE 	P.pageid = #url.id# AND S.isactive = 1 AND teaserposition = 2
ORDER	BY P.reihenfolge 
</cfquery>

<!--- Get active Footer from current Mandant-ID  --->
<!--- FLX HACK solange der footer noch nicht der pageID verlinkt ist = ID = 4  statisch gesetzt --->
<cfquery name="getFooter" datasource="#application.dsn#">
SELECT 	*
FROM	footer
WHERE	mandant = #session.mandant#
		 AND isactive = 1
</cfquery>



<!--- get headlines from Headerpannel (flexslider) elements  --->
<!--- FLX TEST to get just the Headline "Headerpanel Titel" and put into another element --->
<cfquery name="getHeaderpanel_title" datasource="#application.dsn#">
SELECT 	titel
FROM 	headerpanels
WHERE	mandant = #session.mandant#
		AND isactive = 1 
ORDER	BY id
</cfquery>

<!--- get actual headerpanel --->
<cfquery name="getHeaderPanels" datasource="#application.dsn#">
SELECT 	S.* 
FROM 	headerpanels2pages H LEFT JOIN headerpanels S ON H.headerpanelID = S.id
WHERE 	H.pageid = #url.id# AND S.isactive = 1
ORDER	BY H.reihenfolge 
</cfquery>


<!--- push meta into html-head section --->
<cfhtmlhead text='
	<meta name="description" content="#pageProperties.metaDesc#">
	<meta name="keywords" content="#pageProperties.metaKeys#">
	<title>#pageProperties.metaTitel#</title>
' />

<!---  <cfdump var=#getHeaderPanels#>  --->

<!--- <cfdump var=#getFooter# > ---> 

<!--- vor dem templateloader, weil ja die farben alle 3 templates betreffen können --->
<!--- temporär ausgeschaltet da noch nicht ganz okay --->
<!--- 
<cfif pageProperties.templatecolorschema EQ 1>
	<cfset color1 = "red" />
	<cfset color2 = "darkred" />
	<cfset color3 = "orange" />
	<cfset color4 = "yellow" /> --->
<!--- <cfelseif pageProperties.templatecolorschema EQ 2>
	<cfset color1 = "blue" />
	<cfset color2 = "steelblue" />
	<cfset color3 = "darkblue" />
	<cfset color4 = "lightblue" />
<cfelseif pageProperties.templatecolorschema EQ 3>
	<cfset color1 = "green" />
	<cfset color2 = "lightgreen" />
	<cfset color3 = "darkgreen" />
	<cfset color4 = "olive" />

 
 </cfif> --->

<!--- <cfdump var="#getcontent#"> --->

<cfinclude template="template#pageProperties.template#/index.cfm" />