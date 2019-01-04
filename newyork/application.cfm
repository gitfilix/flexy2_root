
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
<cfapplication name="#replace(dirName,'-','','ALL') & 'mag'#" sessionmanagement="yes" setdomaincookies="yes" clientmanagement="no" sessiontimeout="#createTimeSpan(0,0,20,0)#" setclientcookies="yes" scriptprotect="yes">

<!--- set DSN in application scope --->
<cfset application.dsn = "atelier_schief_ch" />

<!--- get mandant by id --->
<cfset session.mandant = getMandantIdByDirName(dirName=dirName) />

<!--- initially set publication to ID 0 --->
<cfparam name="session.pubID" default="14" />

<!--- initially set issue to ID 0 --->
<cfparam name="session.issueID" default="26" />

<!--- initially session.loggedIn --->
<cfparam name="session.loggedIn" default="1" />

<!--- init magazine cfc --->
<cfset fs = createObject('component','dia.futurescreen') />

<cferror type="exception" template="error.cfm" />