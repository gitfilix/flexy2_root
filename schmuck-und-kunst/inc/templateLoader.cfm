<cfprocessingdirective pageencoding="utf-8" />
<!--- TEMPLATE LOADER für Mandant SchmuckundKunst --->
<!--- get service-nav oberstes level --->
<!--- parentUser in der WhereClause ausgeschlossen, da sonst Resulset = 0  --->
<!--- Mandant = serverpath, damit nur die Mandanten Navigations Punkte ausgewählt werden.  --->

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
	<cfset xpath = cgi.PATH_INFO/>
	<cfif xpath EQ "/#session.serverpath#/index.cfm" OR xpath EQ "/#session.serverpath#/ch-de" OR xpath EQ "/#session.serverpath#/ch-de/">
		<cflocation url="http://#cgi.SERVER_NAME#" addtoken="no" />
	</cfif>
</cfif>

<cfquery name="getServiceNav" datasource="#application.dsn#">
SELECT * FROM pages
WHERE 	navpos = 0
		AND parentid = 0
		AND isactive = 1 
		AND mandant = #session.mandant#
		AND lang ="#session.lang#"
ORDER 	BY navorder
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
WHERE 	parentid = #url.id# 
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

<!--- FLX TEST to get just the headerpannel bild --->
<cfquery name="getHeaderpanel_static" datasource="#application.dsn#">
SELECT 	bildname
FROM 	content
WHERE	pageid = #url.id# 		
</cfquery>

<!--- <!--- FLX TEST to get all albums on this page --->
<cfquery name="getAlbums" datasource="#application.dsn#">
SELECT 	*
FROM 	albums
WHERE	pageid = #url.id# 	
</cfquery>
 --->


<!--- get actual headerpanel --->
<cfquery name="getHeaderPanels" datasource="#application.dsn#">
SELECT 	S.* 
FROM 	headerpanels2pages H LEFT JOIN headerpanels S ON H.headerpanelID = S.id
WHERE 	H.pageid = #url.id# AND S.isactive = 1
ORDER	BY H.reihenfolge 
</cfquery>

<!---  <cfdump var=#getHeaderPanels#>  --->
<!--- push meta into html-head section --->
<cfhtmlhead text='
			<meta name="description" content="#pageProperties.metaDesc#">
			<meta name="keywords" content="#pageProperties.metaKeys#">
			<title>Atelier Schief | #pageProperties.metaTitel# | Baden</title>
' />

<cfinclude template="template#pageProperties.template#/index.cfm" />

