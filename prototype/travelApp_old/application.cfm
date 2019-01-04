



<!--- UDF (user defined function) for getting mandantenID from directoryName --->
<cffunction name="getMandantIdByDirName" returntype="boolean" output="yes" access="public">
	<cfargument name="dirName" type="string" required="yes" />
	<cfset getMandantIdByDirName = "" />
	<cfquery name="getMandantIdByDirName" datasource="atelier_schief_ch">
	SELECT 	id
	FROM	mandanten
	WHERE	directoryname = '#arguments.dirName#'
	</cfquery>	
	<cfif getMandantIdByDirName.recordcount EQ 1>
		<cfreturn getMandantIdByDirName.id />
	<cfelse>
		<cfreturn 0 />
	</cfif>	
</cffunction>

<!--- get mandant from url (directoryName) --->
<cfset dirName = listGetAt(cgi.CF_TEMPLATE_PATH,6,'\') />

<!--- set dynmaic application name --->
<cfapplication name="#replace(dirName,'-','','ALL')#" sessionmanagement="yes" setclientcookies="yes" scriptprotect="yes">

<!--- set DSN in application scope --->
<cfset application.dsn = "atelier_schief_ch" />

<!--- get mandant by id --->
<cfset session.mandant = getMandantIdByDirName(dirName=dirName) />

<!--- initially set publication to ID 0 --->
<cfparam name="session.pubID" default="0" />

<!--- initially set issue to ID 0 --->
<cfparam name="session.issueID" default="0" />

<!--- set serverpath --->
<cfparam name="session.serverpath" default="#dirName#" />

<!--- change pubID and issueID in session in session --->
<cfif isdefined("url.pubID") AND isdefined("url.issueID")>
	<cfset session.pubID = url.pubID />
	<cfset session.issueID = url.issueID />
	<cflocation url="#cgi.SCRIPT_NAME#" addtoken="no" />
</cfif>

<!--- init magazine cfc --->
<cfset fs = createObject('component','prototype.travelApp.cfc.futurescreen') />

